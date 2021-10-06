document.addEventListener('turbolinks:load', function() {
  /******************** Page Load Logics ********************
  **********************************************************/
  window.RISK_LABELS = ['very_low', 'low', 'medium', 'high', 'very_high'];

  if ($('#bsl-risks').length >= 1) {
    $('#bsl-risks .bsl-risk-slider').each(function() {
      bsl_risk_slider_fill($(this));
    });
  }

  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('click', '#bsl-tab li', function() {
    href  = $(this).find('a').attr('href');
    parts = href.split('-');
    parts.splice(-1);
    parts.push('desc');
    desc = parts.join('-');

    $('#bsl-desc p').addClass('d-none');
    $(desc).removeClass('d-none');

    setTimeout(function() {
      handle_bsl_previous_proceed();
    }, 500);
  });

  $('body').on('click', '#bsl-proceed-btn', function(e) {
    e.preventDefault();

    var current_tab = $('#bsl-tab li.nav-item a.active').parent('li.nav-item');
    var next_tab    = current_tab.next('li.nav-item');

    if(next_tab.length == 0) {
      return;
    } else {
      $('html, body').animate({ scrollTop: '300px' }, 300);
      next_tab.find('a').trigger('click');
    }
  });

  $('body').on('click', '#bsl-previous-btn', function(e) {
    e.preventDefault();

    var current_tab  = $('#bsl-tab li.nav-item a.active').parent('li.nav-item');
    var previous_tab = current_tab.prev('li.nav-item');

    if(previous_tab.length == 0) {
      return;
    } else {
      $('html, body').animate({ scrollTop: '300px' }, 300);
      previous_tab.find('a').trigger('click');
    }
  });

  $('#bsl-steps')
  .on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.insertBefore($('#bsl-steps-links'));

    bsl_assign_step_number();
    init_select2();
  })
  .on('cocoon:before-remove', function(e, elem) {
    e.preventDefault();

    $('.bsl-step-bin').removeClass('clicked');
    elem.find('.bsl-step-bin').addClass('clicked');

    Swal.fire({
      title: 'Delete',
      text: 'You have selected to delete this step. Press "Yes" to confirm the deletion. Press "No" to cancel.',
      showConfirmButton: true,
      showCancelButton:  true,
      confirmButtonText: 'Yes',
      cancelButtonText:  'No'
    }).then((result) => {
      if (result.isConfirmed) {
        step_bin = $('.bsl-step-bin.clicked');
        step_id  = step_bin.data('step-id');
        step     = step_bin.parents('.bsl-step');

        if (step_id == undefined) {
          step.remove();
          bsl_assign_step_number();
        } else {
          $.ajax({
            url:      '/organisation/steps/' + step_id,
            dataType: 'json',
            type:     'DELETE',
            success: function(result) {
              if (result.deleted) {
                step.next('input[type=hidden]').remove();
                step.remove();
                bsl_assign_step_number();
              } else {
                Swal.fire({ icon: 'error', title: 'Oops!', text: 'Something went wrong.' });
              }
            }
          });
        }
      }
    })
  });

  $('body').on('click', '#bsl-steps .bsl-step-up', function() {
    current_step  = $(this).parents('.bsl-step');
    previous_step = current_step.prevAll('.bsl-step:first');

    if (previous_step.length == 0)
      return;

    swap_bsl_steps(current_step, previous_step, current_step);
  });

  $('body').on('click', '#bsl-steps .bsl-step-down', function() {
    current_step  = $(this).parents('.bsl-step');
    next_step     = current_step.nextAll('.bsl-step:first');

    if (next_step.length == 0)
      return;

    swap_bsl_steps(next_step, current_step, current_step);
  });

  $('body').on('click', '.bsl-step-supplier-modal-opener', function() {
    bsl_step = $(this).parents('.bsl-step');

    $('#bsl-steps .bsl-step').removeClass('functional');
    bsl_step.addClass('functional');

    $('#bsl-step-supplier-modal-container #bsl-step-supplier-modal-number').text(bsl_step.find('.bsl-step-number').text());
    $('#bsl-step-supplier-modal-container #bsl-step-supplier-modal').modal('show');
  });

  $('body').on('click', '#bsl-step-supplier-modal-refresh-list', function() {
    show_loader();
    $.ajax({
      url:      '/organisation/suppliers/all_suppliers',
      dataType: 'json',
      type:     'GET',
      success: function(data) {
        var options = [];
        options.push(new Option('Please select', '', false, false));
        data.forEach(function(e) {
          options.push(new Option(e['name'], e['id'], false, false))
        });

        $('#bsl-step-supplier-modal-suppliers').empty();
        $('#bsl-step-supplier-modal-suppliers').append(options);
        $('#bsl-step-supplier-modal-suppliers').select2().trigger('change');

        toastr.success('List refreshed successfully!');
        hide_loader();
      }
    });
  });

  $('body').on('click', '#bsl-step-supplier-modal-submit-btn', function(e) {
    e.preventDefault();

    bsl_step_modal        = $('#bsl-step-supplier-modal-container #bsl-step-supplier-modal');
    supplier_fore         = bsl_step_modal.find('select[name="supplier[supplier]"] option:selected').text();
    supplier_back         = bsl_step_modal.find('select[name="supplier[supplier]"] option:selected').val();
    party_type_fore       = bsl_step_modal.find('select[name="supplier[party_type]"] option:selected').text();
    party_type_back       = bsl_step_modal.find('select[name="supplier[party_type]"] option:selected').val();
    importance_level_fore = bsl_step_modal.find('input[name="supplier[importance_level]"]:checked').parent().find('label span').text();
    importance_level_back = bsl_step_modal.find('input[name="supplier[importance_level]"]:checked').val();

    if (supplier_back.length == 0 || party_type_back.length == 0 || importance_level_back.length == 0) {
      toastr.error('Please fill all fields');
      return false;
    }

    bsl_step             = $('.bsl-step.functional');
    template             = $('#bsl-step-supplier-selected-supplier-html').data('template');
    supplier_step_number = $.now();
    input_name           = bsl_step.find('.bsl-step-name').attr('name').replace('[name]', '') + '[supplier_steps_attributes][' + supplier_step_number + ']';

    template = template.replace('{{PARTY_TYPE_CLASS}}', party_type_back)
                       .replace('{{SUPPLIER_NAME}}',    supplier_fore)
                       .replace('{{SUPPLIER_FIELD}}',   "<input type='text' value='"+ supplier_back +"' name='"+ input_name +"[supplier_id]'>")
                       .replace('{{BIN_STEP_ID}}',      '')
                       .replace('{{BIN_SUPPLIER_ID}}',  '')
                       .replace('{{SUPPLIER_STEP_PARTY_TYPE}}',             party_type_fore)
                       .replace('{{SUPPLIER_STEP_PARTY_TYPE_FIELD}}',       "<input type='text' value='"+ party_type_back +"' name='"+ input_name +"[party_type]'>")
                       .replace('{{SUPPLIER_STEP_IMPORTANCE_LEVEL}}',       importance_level_fore)
                       .replace('{{SUPPLIER_STEP_IMPORTANCE_LEVEL_FIELD}}', "<input type='text' value='"+ importance_level_back +"' name='"+ input_name +"[importance_level]'>")

    bsl_step.find('.bsl-step-supplier-selected').append(template);
    bsl_step_modal.modal('hide');
  });

  $('body').on('click', '#bsl-steps .bsl-step-supplier-selected-bin', function() {
    container   = $(this).parents('.bsl-step-supplier-selected-container');
    step_id     = $(this).data('step');
    supplier_id = $(this).data('supplier');

    Swal.fire({
      title: 'Delete',
      text: 'You have selected to delete this supplier from step. Press "Yes" to confirm the deletion. Press "No" to cancel.',
      showConfirmButton: true,
      showCancelButton:  true,
      confirmButtonText: 'Yes',
      cancelButtonText:  'No'
    }).then((result) => {
      if (result.isConfirmed) {
        if (step_id == '') {
          container.remove();
        } else {
          $.ajax({
            url: '/organisation/steps/'+ step_id +'/supplier_step?supplier_id='+ supplier_id,
            dataType: 'json',
            type: 'DELETE',
            success: function(result) {
              if (result.deleted) {
                container.next('input[type="hidden"]').remove();
                container.remove();
              }
            }
          })
        }
      }
    });
  });

  $('body').on('input', '.bsl-risk-slider', function() {
    bsl_risk_slider_fill($(this));
  });

  $('body').on('change', '#bsl-risks .justification-requirer', function() {
    $(this).parents('.bsl-risk').find('.justification-required').attr('required', true);
  });

  $('body').on('focusout', '.risk-appetite', function(){
    sla_attr_val         = parseFloat($('#' + $(this).attr('data-sla')).val());
    impact_tolerance_val = parseFloat($(this).val());
    warning_message_id    = '#warning_message_'+$(this).attr('data-sla').replace("business_service_line_sla_attributes_","");
    if ($(this).attr('data-percent') == 'true'){
      if(impact_tolerance_val > sla_attr_val){
        $(warning_message_id).removeClass('d-none').addClass('d-block');
      }else{
        $(warning_message_id).removeClass('d-block').addClass('d-none');
      }
    }
    else if(!$(this).attr('data-sla').includes("transactions_per_second")){
      if(impact_tolerance_val < sla_attr_val){
        $(warning_message_id).removeClass('d-none').addClass('d-block');
      }else{
        $(warning_message_id).removeClass('d-block').addClass('d-none');
      }
    }
  });

  $('body').on('click', '#save-bsl-form', function(e) {
    e.preventDefault();

    form = $(this).parents('#bsl-form');

    form.validate({ ignore: [] });
    if (form.valid() && $('.warning-error.d-block').length > 0){
      $('html, body').animate({
        scrollTop: $(".warning-error.d-block").offset().top - 100
      });
      return false;
    }
    if (form.valid()) {
      return form.submit();
    } else {
      error_elem     = form.find(':input.error:first');
      error_tab      = error_elem.parents('.tab-pane').attr('id');
      error_tab_link = form.find('a[href="#'+ error_tab +'"]');
      error_tab_link.click();
      setTimeout(function() {
        $('html, body').animate({
          'scrollTop' : error_elem.parents('.field-scroll').position().top
        });
        if (error_elem.hasClass('expandable') && !error_elem.parents('.collapse').hasClass('show')) {
          error_elem.parents('.field-scroll').find('a[data-toggle="collapse"]').click();
        }
        error_elem.focus();
      }, 500);
      return false;
    }
  });

  $('body').on('click', '.sla-compound-resilience', function() {
    $.ajax({
      url:      '/organisation/business_service_lines/find_compound_resilience_data',
      dataType: 'script',
      type:     'GET',
      async:     false,
      data:     {
        args:           $(this).data('args'),
        data_append_to: $(this).data('append-to'),
        partial_name:   $(this).data('partial-name')
      }
    });
  });

  /******************** Helper Methods ********************
  ********************************************************/
  function handle_bsl_previous_proceed() {
    var current_tab  = $('#bsl-tab li.nav-item a.active').parent('li.nav-item');
    var next_tab     = current_tab.next('li.nav-item');
    var previous_tab = current_tab.prev('li.nav-item');

    if (previous_tab.length == 0)
      $('#bsl-previous-btn').addClass('d-none');
    else
      $('#bsl-previous-btn').removeClass('d-none');

    if (next_tab.length == 0)
      $('#bsl-proceed-btn').addClass('d-none');
    else
      $('#bsl-proceed-btn').removeClass('d-none');
  }

  function bsl_assign_step_number() {
    $('#bsl-steps .bsl-step').each(function(index) {
      $(this).find('.bsl-step-number').text(index + 1);
      $(this).find('.bsl-step-number-field').val(index + 1);
    });
  }

  function bsl_risk_slider_fill(e) {
    var parent = e.parents('.bsl-risk');
    var value  = parseInt(e.val());

    parent.find('.bsl-risk-slider-value').val(RISK_LABELS[value]);
    parent.find('.bsl-risk-slider-indicator').addClass('d-none');
    parent.find('.bsl-risk-slider-indicator-'+ value).removeClass('d-none');

    fill = (value / 4) * 100;
    e.css({ 'background': 'linear-gradient(to right, #000 0%, #000 ' + fill + '%, #F3F5FA ' + fill + '%, #F3F5FA 100%)' });
  }

  function swap_bsl_steps(current_step, swap_step, scroll_to) {
    current_input = current_step.next('input[type="hidden"]');

    $(current_step).insertBefore(swap_step);
    $(current_input).insertAfter(current_step);

    bsl_assign_step_number();

    $('html, body').animate({
      'scrollTop' : $(scroll_to).position().top
    });
  }
});

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

    supplier         = $('#bsl-step-supplier-modal-container').find('select[name="supplier[supplier]"]').val();
    party_type       = $('#bsl-step-supplier-modal-container').find('select[name="supplier[party_type]"]').val();
    importance_level = $('#bsl-step-supplier-modal-container').find('input[name="supplier[importance_level]"]').val();

    if (supplier.length == 0 || party_type.length == 0 || importance_level.length == 0) {
      toastr.error('Please fill all fields');
      return false;
    }
    // debugger
    bsl_step = $('.bsl-step.functional');
    template = $('#bsl-step-supplier-selected-supplier-html').data('template');
    // timestamp = new_elem.find('.bsl-step-field:first').attr('name').split('][')[1];
    // var opened_modal = $(this).parents('.modal.add-supplier-modal.show');

    // $.ajax({
    //   // url:  '/organisation/suppliers/',
    //   // dataType: 'script',
    //   // type: 'POST',
    //   // data: {
    //     // supplier: {
    //       // name:             opened_modal.find("input[name='supplier[name]']").val(),
    //       // party_type:       opened_modal.find("select[name='supplier[party_type]']").val(),
    //       // importance_level: opened_modal.find("input[name='supplier[importance_level]']:checked").val(),
    //       // country_unit:     opened_modal.find("select[name='supplier[country]']").val()
    //     // }
    //   // },
    //   // success: function(element) {
    //   //   // var supplier     = JSON.parse(element);
    //   //   // var opened_modal = $('.modal.add-supplier-modal.show');

    //   //   // if (supplier.errors) {
    //   //   //   // supplier.errors.forEach(function(error, index) {
    //   //   //   //   toastr.error(error)
    //   //   //   // });
    //   //   // } else {
    //   //   //   // var new_supplier = new Option(supplier.resp.name, supplier.resp.id, false, false);
    //   //   //   // $('#bsl-steps .bsl-step-supplier-selector').append(new_supplier).trigger('change');

    //   //   //   // select2_choose_option(opened_modal.find('.bsl-step-supplier-selector'), supplier.resp.id);

    //   //   //   // opened_modal.find(":input[name^='supplier']").val('');
    //   //   //   // toastr.success('Supplier created successfully!');
    //   //   // }
    //   // }
    // });
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
        $.ajax({
          url: '/organisation/steps/'+ step_id +'/supplier_step?supplier_id='+ supplier_id,
          dataType: 'json',
          type: 'DELETE',
          success: function(result) {
            if (result.deleted) {
              select2_remove_option(container.parents('.bsl-step').find('.bsl-step-supplier-selector'), supplier_id);
              container.remove();
            }
          }
        })
      }
    });
  });

  $('body').on('input', '.bsl-risk-slider', function() {
    bsl_risk_slider_fill($(this));
  });

  $('body').on('click', '#save-bsl-form', function(e) {
    e.preventDefault();
    form = $(this).parents('#bsl-form');

    form.validate({ ignore: [] });
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

  $('body').on('change', '#bsl-risks .justification-requirer', function() {
    $(this).parents('.bsl-risk').find('.justification-required').attr('required', true);
  });

  /******************** Helper Methods ********************
  ********************************************************/
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

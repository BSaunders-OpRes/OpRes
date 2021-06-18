document.addEventListener('turbolinks:load', function() {
  /******************** Page Load Logics ********************
  **********************************************************/
  if ($('#bsl-risks').length >= 1) {
    $('#bsl-risks .bsl-risk-slider').each(function() {
      bsl_risk_slider_fill($(this));
    });
  }

  /******************** Event Bindings ********************
  ********************************************************/
  $('#bsl-tab li').click(function() {
    href  = $(this).find('a').attr('href');
    parts = href.split('-');
    parts.splice(-1);
    parts.push('desc');
    desc = parts.join('-');

    $('#bsl-desc p').addClass('d-none');
    $(desc).removeClass('d-none');
  });

  $('#bsl-proceed-btn').click(function(e) {
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

  $('#bsl-previous-btn').click(function(e) {
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

  $('body').on('click', '.bsl-step-supplier-form-submit-btn', function(e) {
    e.preventDefault();
    var opened_modal = $(this).parents('.modal.add-supplier-modal.show');

    $.ajax({
      url:  '/organisation/suppliers/',
      dataType: 'script',
      type: 'POST',
      data: {
        supplier: {
          name:         opened_modal.find("input[name='supplier[name]']").val(),
          party_type:   opened_modal.find("select[name='supplier[party_type]']").val(),
          status:       opened_modal.find("input[name='supplier[status]']:checked").val(),
          country_unit: opened_modal.find("select[name='supplier[country]']").val()
        }
      },
      success: function(element) {
        var supplier     = JSON.parse(element);
        var opened_modal = $('.modal.add-supplier-modal.show');

        toastr.options = { closeButton: true, progressBar: true }

        if (supplier.errors) {
          supplier.errors.forEach(function(error, index) {
            toastr.error(error)
          });
        } else {
          var new_supplier = new Option(supplier.resp.name, supplier.resp.id, false, false);
          $('#bsl-steps .bsl-step-supplier-selector').append(new_supplier).trigger('change');
          var current_supplier_selector = opened_modal.find('.bsl-step-supplier-selector');
          var current_supplier_values   = current_supplier_selector.val();
          current_supplier_values.push(supplier.resp.id);
          current_supplier_selector.val(current_supplier_values);
          current_supplier_selector.select2().trigger('change');
          opened_modal.find(":input[name^='supplier']").val('');
          toastr.success('Supplier created successfully!');
        }
      }
    });
  });

  $('#bsl-steps')
  .on('cocoon:after-insert', function(e, insertedItem) {
    bsl_assign_step_number();

    new_elem  = $(insertedItem[0]);
    timestamp = new_elem.find('.bsl-step-field:first').attr('name').split('][')[1];

    new_elem.find('.select2').select2();

    new_elem.find('.bsl-step-supplier-modal-opener').attr('data-target', '#bsl-step-supplier-modal-' + timestamp);
    new_elem.find('.bsl-step-supplier-modal').attr('id', 'bsl-step-supplier-modal-' + timestamp);

    new_elem.find('.bsl-step-supplier-status.critical-radio').attr('id', 'critical-' + timestamp);
    new_elem.find('.bsl-step-supplier-status.critical-radio').siblings('label').attr('for', 'critical-' + timestamp);

    new_elem.find('.bsl-step-supplier-status.important-radio').attr('id', 'important-' + timestamp);
    new_elem.find('.bsl-step-supplier-status.important-radio').siblings('label').attr('for', 'important-' + timestamp);

    new_elem.find('.load-countries-from-region').attr('data-append-countries-to', 'bsl-step-supplier-country-' + timestamp);
    new_elem.find('.bsl-step-supplier-countries').attr('id', 'bsl-step-supplier-country-' + timestamp);
  })
  .on('cocoon:after-remove', function(e) {
    bsl_assign_step_number();
  });

  $('body').on('input', '.bsl-risk-slider', function() {
    bsl_risk_slider_fill($(this));
  });

  // $('body').on('click', '#save-bsl-form', function(e) {
  //   e.preventDefault();
  //   form = $(this).parents('#bsl-form');

  //   if (form.valid()) {
  //     return form.submit();
  //   } else {
  //     return false;
  //   }
  // });

  /******************** Helper Methods ********************
  ********************************************************/
  function bsl_assign_step_number() {
    $('#bsl-steps .nested-fields').each(function(index) {
      $(this).find('.bsl-step-number').text(index + 1);
      $(this).find('.bsl-step-number-field').val(index + 1);
    });
  }

  function bsl_risk_slider_fill(e) {
    var parent = e.parents('.nested-fields');
    var value  = e.val();

    parent.find('.bsl-risk-slider-value').val(value);
    e.css({ 'background': 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)' });
  }
});

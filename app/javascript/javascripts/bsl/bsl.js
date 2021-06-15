document.addEventListener('turbolinks:load', function() {

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

  $('body').on('click', '.supplier_form_submit_btn', function(e) {
    e.preventDefault();

    const id = $(this).data('stepid')
    const openedModal = $(this).closest('.modal')
    const name = openedModal.find('#name').val();
    const party_type = openedModal.find('#party_type').val();
    const country_unit = openedModal.find('#supplier_country').val();
    const input_fields = $(this).closest('form').find("input[type=text], select");
    let   status = openedModal.find("input[name='supplier_status']:checked").val();

    $.ajax({
      url:  '/organisation/suppliers/',
      dataType: 'script',
      type: 'POST',
      data: {
        supplier: {
          name,
          party_type,
          country_unit,
          status
        }
      },
      success: function(element){
        const supplier = JSON.parse(element)

        toastr.options = { closeButton: true, progressBar: true }
        if(supplier.errors) {
          return supplier.errors.forEach(function(error, index) {
            toastr.error(error)
          })
        }

        const newSupplier = new Option(supplier.resp.name, supplier.resp.id, false, true)
        $('.supplier-selector').append(newSupplier).trigger('change');
        toastr.success('Supplier created successfully!')
        input_fields.val('');
      }
    });
  });

  $('body').on('click', '.delete-supplier', function(e){
    //To delete a supplier from bsl steps
  });

  $('#dynamic-bsl-steps-block').on('cocoon:after-insert', function(e, insertedItem) {
    new_elem    = $(this).find('.nested-fields').last()
    new_elem_modal = $(this).find('.modal').last()
    step_number = $(this).find('.nested-fields').length
    id = insertedItem.find('.step-fields').first().attr('id').split('_').slice(-2)[0]

    new_elem.find('#step-number').text('Step ' + step_number)
    new_elem.find('.toggle-modal').attr('data-target', '#new_supplier_modal_' + step_number)
    new_elem_modal.find('#modal-step-number').text('add supplier to step ' + step_number)
    new_elem_modal.attr('id', 'new_supplier_modal_' + step_number)

    insertedItem.find('.supplier-selector').attr('name', 'business_service_line[steps_attributes][' + id + '][supplier_ids][]')
    insertedItem.find('.critical-radio').attr('id', 'critical-' + step_number)
    insertedItem.find('.critical-label').attr('for', 'critical-' + step_number)
    insertedItem.find('.important-radio').attr('id', 'important-' + step_number)
    insertedItem.find('.important-label').attr('for', 'important-' + step_number)
    insertedItem.find('.supplier-selector').attr('id', 'supplier-selector-' + step_number)
    insertedItem.find('.supplier_form_submit_btn').attr('data-stepid', step_number)
    insertedItem.find('.select2').select2();
  });
});


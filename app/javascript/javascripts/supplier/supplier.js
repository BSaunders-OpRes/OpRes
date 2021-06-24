document.addEventListener('turbolinks:load', function() {
  /******************** Page Load Logics ********************
  **********************************************************/
  $('#supplier-key-contact-select2')
  .select2()
  .on('select2:open', function() {
    $('.select2-results:not(:has(a))').append('<a href="javascript:void(0);" id="supplier-key-contact-new" class="btn p-1 btn-sm primary-btn m-1 pull-right">New contact</a>');
  });

  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('click', '#supplier-key-contact-new', function(e) {
    $('#supplier-key-contact-select2').select2();
    $.ajax({
      url:  '/organisation/key_contacts/new',
      type: 'GET',
      dataType: 'script'
    });
  });


  $('body').on('change', '.load-chp-region-from-chp select', function() {
    selected_val      = $(this).val();
    selected_val_text =   selected_val_text = $('#supplier_cloud_hosting_provider_id option[value= \'' + selected_val+ '\']').text();
    if (selected_val_text == 'Private Cloud'){
      $('#region-dropdown').parent().addClass('d-none');
      $('#services-options').addClass('d-none');
      $('#private-cloud-description').removeClass('d-none');
      $('#supplier_cloud_hosting_provider_region_id').val('');

    }
    else{
      $('#private-cloud-description').addClass('d-none');
      $('#region-dropdown').parent().removeClass('d-none');
      $('#services-options').removeClass('d-none');

      parent = $(this).parents('.load-chp-region-from-chp');
      $.ajax({
        url:  '/organisation/cloud_hosting_providers/load_chp_regions_and_services',
        type: 'GET',
        data: {
          cloud_hosting_provider_id:       $(this).val(),
          append_regions_to:       parent.data('append-regions-to'),
          append_services_to:      parent.data('append-services-to'),
          regions_param_name:      parent.data('regions-param-name'),
          services_param_name:     parent.data('services-param-name'),
          supplier_id:             parent.data('supplier-id')
        }
      });
    }
  });
});

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

  $('body').on('change', 'select#load-cloud-hosting-provider-regions-services', function() {
    cloud_hosting_provider = $(this).val();
    if (cloud_hosting_provider === '') {
      $('#cloud-hosting-provider-regions-services').html('');
    } else {
      supplier_id = $(this).data('supplier');
      $.ajax({
        url:  '/organisation/cloud_hosting_providers/'+ cloud_hosting_provider +'/regions_services?supplier_id='+ supplier_id,
        type: 'GET'
      });
    }
  });

  $('body').on('click', '#select-all-chp-services', function() {
    if (this.checked) {
      $('#cloud-hosting-provider-service .service').prop('checked', true);
    } else {
      $('#cloud-hosting-provider-service .service').prop('checked', false);
    }
  });

  $('body').on('keyup', '#chp-service-search-filter', function() {
    var value = $(this).val().toLowerCase();
    $('#cloud-hosting-provider-service .service-list').filter(function(index, ele) {
      $(this).toggle($(ele).text().toLowerCase().indexOf(value) > -1)
    });
  });

  $('body').on('click', '#chp-service-search-filter, .service-list .service, #select-all-chp-services', function() {
    count_chp_services();
  });

  $('body').on('change', '.sub-supplier-chp', function() {
    chp                  = $(this);
    sub_supplier         = chp.parents('.sub-supplier');
    description_block    = sub_supplier.find('.sub-supplier-chp-description');
    selected_option_text = chp.find('option:selected').text();

    if (selected_option_text == 'Private Cloud') {
      description_block.removeClass('d-none').val('');
    } else {
      description_block.addClass('d-none').val('');
    }
  });

  $('body').on('change', '#end-date, #start-date', function() {
    var startDate = process_date($('#start-date').val());
    var endDate   = process_date($('#end-date').val());
    if (startDate > endDate) {
      $('#end-date').val('');
      $('.end-date-errors').addClass('d-block')
    } else {
      $('.end-date-errors').removeClass('d-block')
    }
  });

  $('body').on('click', '.sla-compound-resilience', function() {
    $.ajax({
      url:      '/organisation/suppliers/find_compound_resilience_data',
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

  function process_date(date){
    parts = date.split('/');
    date  = new Date(parts[1] + '/' + parts[0] + '/' + parts[2]);
    return date.getTime();
  }

  function count_chp_services() {
    $('.selected-service-count').removeClass('d-none');
    $('.empty-services-message').removeClass('d-block').addClass('d-none');
    var selected_service_count = $('#cloud-hosting-provider-service .service-list').find('input[type="checkbox"]').filter(':checked').length
    $('.selected-service-count').text('selected services: ' + selected_service_count);
  }


  $('body').on('click', '#supplier-submit-btn', function(e) {
    var selected_service_count = $('#cloud-hosting-provider-service .service-list').find('input[type="checkbox"]').filter(':checked').length
    var selected_region        = $('#supplier_cloud_hosting_provider_region_id').val();
    var cloud_hosting_provider = $('#load-cloud-hosting-provider-regions-services').val();

    if (cloud_hosting_provider != '' && selected_service_count == 0 && selected_region != ''){
      e.preventDefault();
      $('.empty-services-message').addClass('d-block');
      $('html, body').animate({
        scrollTop: $("#supplier-empty-services-message").offset().top - 150
      }, 1000);
    }
  });
});

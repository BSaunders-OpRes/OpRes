document.addEventListener('turbolinks:load', function() {

  $('body').on('click', '.chp-data', function() {
    $.ajax({
      url:      '/organisation/business_service_lines/find_chp_data',
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
});

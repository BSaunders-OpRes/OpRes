document.addEventListener('turbolinks:load', function() {
  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('change', '.search-bsl-name', function() {
    search_bsls();
  });

  $('body').on('change', '.search-bsl-tier, .search-bsl-regional-unit, .search-bsl-institution-unit, .search-bsl-product', function(e) {
    search_bsls();
  });

  /******************** Main Methods ********************
  ******************************************************/
  function search_bsls() {
    show_loader();
    $.ajax({
      url:      '/organisation/administration_portal',
      dataType: 'script',
      type:     'GET',
      data: {
        bsl: {
          name:              $('#search-bsl-name').val(),
          tiers:             get_checked_values('.search-bsl-tier'),
          regional_units:    get_checked_values('.search-bsl-regional-unit'),
          institution_units: get_checked_values('.search-bsl-institution-unit'),
          products:          get_checked_values('.search-bsl-product')
        }
      }
    });
  }

  /******************** Helper Methods ********************
  ********************************************************/
  function get_checked_values(identifier) {
    var values = [];

    $(identifier).each(function() {
      if ($(this).is(':checked'))
        values.push($(this).val());
    });

    return values;
  }
});

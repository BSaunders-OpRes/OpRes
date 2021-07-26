document.addEventListener('turbolinks:load', function() {
  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('change', '.search-bsl-name, .search-supplier-name', function() {
    search_bsls_suppliers();
  });

  $('body').on('change', '.search-bsl-tier, .search-bsl-regional-unit, .search-bsl-institution-unit, .search-bsl-product, .search-supplier-country-unit, .search-supplier-regional-unit', function(e) {
    search_bsls_suppliers();
  });

  /******************** Main Methods ********************
  ******************************************************/
  function search_bsls_suppliers() {
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
        },
        supplier: {
          name:           $('#search-supplier-name').val(),
          country_units:  get_checked_values('.search-supplier-country-unit'),
          regional_units: get_checked_values('.search-supplier-regional-unit')
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

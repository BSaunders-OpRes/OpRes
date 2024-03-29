document.addEventListener('turbolinks:load', function() {
  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('click', '.empty-input-field', function (){
    $(this).parents('.table-search-field').find('input').val('')
    search_bsls_suppliers();
  });
  $('body').on('keyup', '.search-bsl-name, .search-supplier-name', function() {
    search_bsls_suppliers();
  });

  $('body').on('change', '.search-bsl-tier, .search-bsl-regional-unit, .search-bsl-institution-unit, .search-bsl-product, .search-supplier-country-unit, .search-supplier-regional-unit', function(e) {
    search_bsls_suppliers();
  });

  $('body').on('click', '.clear-input-field', function() {
    $(this).parents('.table-search-field').find('input').val('');
    search_data($(this).data('url'));
  });



  /******************** Main Methods ********************
  ******************************************************/
  function search_bsls_suppliers() {
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

  /******************** Search Helper Methods ********************
  ********************************************************/
  function search_data(url) {
    $.ajax({
      url:      url,
      dataType: 'script',
      type:     'GET',
      data: {
        query: ''
      }
    });
  }
});

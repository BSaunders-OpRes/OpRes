document.addEventListener('turbolinks:load', function() {
  /******************** Regions Dropdown Template ********************
    <div 
      class="load-countries-from-region"
      data-append-countries-to=""    // id where countries will be populated.
      data-append-institutions-to="" // id where institutions will be populated.
      data-append-products-to=""     // id where products will be populated.
      data-append-channels-to=""     // id where channels will be populated.
      data-country-param-name=""     // name of the country parameter.
      data-institution-param-name="" // name of the institution parameter.
      data-product-param-name=""     // name of the product parameter.
      data-channel-param-name=""     // name of the channel parameter.
    >
      <select></select>
    </div>
  *******************************************************************/
  $('body').on('change', '.load-countries-from-region select', function() {
    parent = $(this).parents('.load-countries-from-region');
    $.ajax({
      url:  '/organisation/unit_hierarchys/load_countries',
      type: 'GET',
      data: {
        regional_unit_id:       $(this).val(),
        append_countries_to:    parent.data('append-countries-to'),
        append_institutions_to: parent.data('append-institutions-to'),
        append_products_to:     parent.data('append-products-to'),
        append_channels_to:     parent.data('append-channels-to'),
        country_param_name:     parent.data('country-param-name'),
        institution_param_name: parent.data('institution-param-name'),
        product_param_name:     parent.data('product-param-name'),
        channel_param_name:     parent.data('channel-param-name')
      }
    });
  });

  /******************** Countries Dropdown Template ********************
  <div 
    class="load-institutions-from-country"
    data-append-institutions-to=""  // id where institutions will be populated.
    data-append-products-to=""      // id where products will be populated.
    data-append-channels-to=""      // id where channels will be populated.
    data-institution-param-name=""  // name of the institution parameter.
    data-product-param-name=""      // name of the product parameter.
    data-channel-param-name=""      // name of the channel parameter.
  >
    <select></select>
  </div>
  *********************************************************************/
  $('body').on('change', '.load-institutions-from-country select', function() {
    parent = $(this).parents('.load-institutions-from-country');
    $.ajax({
      url: '/organisation/unit_hierarchys/load_institutions',
      type: 'GET',
      data: { 
        country_unit_id:        $(this).val(),
        append_institutions_to: parent.data('append-institutions-to'),
        append_products_to:     parent.data('append-products-to'),
        append_channels_to:     parent.data('append-channels-to'),
        institution_param_name: parent.data('institution-param-name'),
        product_param_name:     parent.data('product-param-name'),
        channel_param_name:     parent.data('channel-param-name')
      }
    });
  });

  /******************** Institutions Dropdown Template ********************
  <div
    class="load-products-channels-from-institution"
    data-append-products-to=""   // id where products will be populated.
    data-append-channels-to=""   // id where channels will be populated.
    data-product-param-name=""   // name of the product parameter.
    data-channel-param-name=""   // name of the channel parameter.
  >
    <select></select>
  </div>
  ************************************************************************/
  $('body').on('change', '.load-products-channels-from-institution select', function() {
    parent = $(this).parents('.load-products-channels-from-institution');
    $.ajax({
      url:  '/organisation/unit_hierarchys/load_products_channels',
      type: 'GET',
      data: {
        institution_unit_id:  $(this).val(),
        append_products_to:   parent.data('append-products-to'),
        append_channels_to:   parent.data('append-channels-to'),
        product_param_name:   parent.data('product-param-name'),
        channel_param_name:   parent.data('channel-param-name')
      }
    });
  });
});

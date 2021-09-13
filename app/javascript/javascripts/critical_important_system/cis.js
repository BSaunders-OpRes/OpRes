document.addEventListener('turbolinks:load', function() {
  /******************** Event Bindings ********************
  ********************************************************/
  $('.public-cloud-system a').on('click', function(){
    $('.public-cloud-system a.active').removeClass('active');
    $(this).addClass("active");
    $('#cm_model').val(this.text.toLowerCase())
  });

  $('.private-cloud-system a').on('click', function(){
    $('.private-cloud-system a.active').removeClass('active');
    $(this).addClass("active");
    $('#cm_model').val(this.text.toLowerCase())
  });

  $('#clear-field').on('click', function(){
    $('#search-filter').val('');
  });

  $(".segmentation-options input[type=checkbox]").on('click', function(){
    if (this.checked){
      segmentation_suppliers = getFilterValues($(".segmentation-options .segmentation_suppliers input:checked"))
      segmentation_regions = getFilterValues($(".segmentation-options .segmentation_regions input:checked"))
      segmentation_countries = getFilterValues($(".segmentation-options .segmentation_countries input:checked"))
      segmentation_firms = getFilterValues($(".segmentation-options .segmentation_firms input:checked"))
      segmentation_products = getFilterValues($(".segmentation-options .segmentation_products input:checked"))
      
      $.ajax({
        url:      '/organisation/dashboard_break_downs/critical_important_system',
        dataType: 'script',
        type:     'GET',
        async:     false,
        data: {
          supplier_type: segmentation_suppliers,
          regions: segmentation_regions,
          countries: segmentation_countries,
          firms: segmentation_firms,
          products: segmentation_products
        }
      });
    }
  });

  function getFilterValues(filterObject) {
    dataFilters = []
    filterObject.map(function( i, e ) {
      dataFilters.push(e.getAttribute('data-args'));
    });
    return dataFilters;
  }
});




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

  $('body').on('click', '#business_service_line_region', function() {
    $.ajax({
      url:  '/organisation/units/load_countries',
      type: 'GET',
      data: { regional_unit_id: $(this).val() },
    });
  });

  $('body').on('change', '#business_service_line_country', function() {
    $.ajax({
      url: '/organisation/units/load_institutions',
      type: 'GET',
      data: { country_unit_id: $(this).val() },
    });
  });

  $('body').on('change', '#business_service_line_institution', function() {
    $.ajax({
      url:  '/organisation/units/load_products_channels',
      type: 'GET',
      data: { institution_unit_id: $(this).val() },
    });
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
});


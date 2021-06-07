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

  $('body').on('click', '#create_suppliers', function() {
    $.ajax({
      url:  '/organisation/suppliers/new',
      type: 'GET',
      dataType: 'script'
    });
  });

  $('body').on('click', '#supplier_from_submit', function(e) {
    e.preventDefault();
    var name = $('#name').val();
    var party_type = $('#party_type').val();
    var unit_id = $('#supplier_country').val();
    var status = "Critical";

    if($('#important').is(':checked'))
      status = "Important";

    $.ajax({
      url:  '/organisation/suppliers/',
      dataType: 'script',
      type: 'POST',
      data: {
        supplier: {
          name,
          party_type,
          unit_id,
          status
        }
      }
    });
  });

  $('body').on('change', '#select_supplier', function(e){
    $.ajax({
      url:  '/organisation/suppliers/' + e.target.value,
      type: 'GET',
      dataType: 'script'
    });
  })
});


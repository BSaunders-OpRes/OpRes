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

  $(".filter-value").on('click', function(){
    $.ajax({
      url:      '/organisation/dashboard_break_downs/critical_important_system',
      dataType: 'script',
      type:     'GET',
      async:     false,
      data:     {
        critical: $(this).data('args')
      }
    });
  });
});




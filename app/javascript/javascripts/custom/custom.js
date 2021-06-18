document.addEventListener('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();

  $('#close_sidebar').click(function() {
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
    $('body').removeClass('overflow-hidden')
  });

  $('#open_sidebar').click(function(e) {
    e.stopPropagation();
    $('.sidebar').css('width', '290');
    $('.content').addClass('blur');
    $('.header').addClass('blur');
    $('body').addClass('overflow-hidden')
  });

  $('.content, .header').click(function(e) {
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
    $('body').removeClass('overflow-hidden')
  });

  $('.custom-dropdown .dropdown-menu').click(function(e) {
    e.stopPropagation()
  });

  $('.custom-dropdown .dropdown-menu label > span').click(function() {
    $(this).toggleClass('font-600')
  });
});

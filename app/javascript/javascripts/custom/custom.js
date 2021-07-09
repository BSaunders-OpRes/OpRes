document.addEventListener('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();

  $('#close_sidebar').click(function() {
    $('body').removeClass('overflow-hidden')
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
  });

  $('#open_sidebar').click(function(e) {
    e.stopPropagation();
    $('body').addClass('overflow-hidden')
    $('.sidebar').css('width', '290');
    $('.content').addClass('blur');
    $('.header').addClass('blur');
  });

  $('.container, .header').click(function(e) {
    $('body').removeClass('overflow-hidden')
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
  });

  $('.custom-dropdown .dropdown-menu').click(function(e) {
    e.stopPropagation()
  });

  $('.custom-dropdown .dropdown-menu label > span').click(function() {
    $(this).toggleClass('font-600')
  });
});

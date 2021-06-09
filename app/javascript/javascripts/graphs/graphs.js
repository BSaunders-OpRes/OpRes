document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '#graph-breakdown .links a', function(e) {
    e.preventDefault();
    var parent = $(this).parents('.links');
    var href = $(this).attr('href');
    $('html, body').animate({
      scrollTop: $(href).offset().top - 100
    }, '300');

    parent.addClass('active-white').siblings().removeClass('active-white')
  });

  if ($('.fixed-secondary-sidebar').length >= 1) {
    $(window).scroll(function() {
      if($(window).scrollTop() > 10) {
        $('.fixed-secondary-sidebar').addClass('sticky-top').removeClass('position-static');
      } else {
        $('.fixed-secondary-sidebar').addClass('position-static').removeClass('sticky-top');
      }
    });
  }
})

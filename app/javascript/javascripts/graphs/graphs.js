document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '#graph-breakdown .links a', function(e) {
    e.preventDefault();
    var parent = $(this).parents('.links');
    var href = $(this).attr('href');
    var leave_margin = (window.innerWidth < 576) ? 290 : 100;

    $('html, body').animate({
      scrollTop: $(href).offset().top - leave_margin
    }, '300');
    $('#section1').addClass('pt-xs-5');
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
  $('.secondary-sidebar-icon').on('click', function(){
    $('.fixed-secondary-sidebar').addClass('p-300');
  })
    $('.fixed-secondary-sidebar .fa-times-circle').on('click', function(){
    $('.fixed-secondary-sidebar').removeClass('p-300');
    $('#section1').removeClass('pt-xs-5');
  })
})

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
  $('input[type=number]').on('mousewheel', function(){
    var el = $(this);
    el.blur();
    setTimeout(function(){
      el.focus();
    }, 10);
  });

  $('.sidebar .list-unstyled li a.close-bar').on('click', function() {
    $('body').removeClass('overflow-hidden')
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
  })

  $('.container, .header').click(function(e) {
    $('body').removeClass('overflow-hidden')
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
  });

  $('body').on('click', '#sticky-sidebar-demo .links a', function(e) {
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
  });

  $('.fixed-secondary-sidebar .fa-times-circle').on('click', function(){
    $('.fixed-secondary-sidebar').removeClass('p-300');
    $('#section1').removeClass('pt-xs-5');
  });

  $('.custom-dropdown .dropdown-menu, .general-dropdown .dropdown-menu').click(function(e) {
    e.stopPropagation()
  });

  $('.custom-dropdown .dropdown-menu label > span').click(function() {
    $(this).toggleClass('font-600')
  });

  $('body').on('change', '.inputfile', function(e) {
    $('.file-attach').removeClass('d-none').addClass('d-block')
    $('.file-name').text(e.target.value.split('\\').pop())
    $('.file-size').text((this.files[0].size/1000).toFixed(2)+'KB')
    $(this).parents('.inputfile-box').find('#file-name').text(e.target.value.split('\\').pop());

    if ($(this.files[0].size/1000).length > 0){
      $('#attachment-icon').removeClass('d-none').addClass('d-block')
    }
  });

  $('body').on('change', '#compliance_tier', function(e) {
    if(this.value === 'high'){
      $('.compliance_rule_reminder').val("60");
    }else if(this.value === 'very_high'){
      $('.compliance_rule_reminder').val("80");
    }else if(this.value === 'medium'){
      $('.compliance_rule_reminder').val("40");
    }else{
      $('.compliance_rule_reminder').val("20");
    }
  });
});

document.addEventListener('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();

  $('#close_sidebar').click(function() {
    $('.sidebar').css('width', '0');
    $('.content').removeClass('blur');
    $('.header').removeClass('blur');
  });

  $('#open_sidebar').click(function() {
    $('.sidebar').css('width', '290');
    $('.content').addClass('blur');
    $('.header').addClass('blur');
  });

  $('#bsl-tab li').click(function() {
    href  = $(this).find('a').attr('href');
    parts = href.split('-');
    parts.splice(-1);
    parts.push('desc');
    desc = parts.join('-');

    $('#bsl-desc p').addClass('d-none');
    $(desc).removeClass('d-none');
  });

  $('body').on('click', '.faded-popover-wrapper .faded-popover-title', function() {
    $('.faded-popover-wrapper .faded-popover-content').addClass('d-none');
    $(this).siblings('.faded-popover-content').removeClass('d-none');
    $(this).find('.text').css({ width: '100px', opacity: '1' });
  });

  $('body').on('click', '.faded-popover-wrapper .faded-popover-content i', function() {
    $(this).parent('.faded-popover-content').addClass('d-none');
    $(this).parent().siblings('.faded-popover-title').find('.text').css({ width: '0px', opacity: '0' });
  });

  $('body').on('click', '.accordion-wrapper .accordion-arrow', function() {
    accordion_content = $(this).parent('.accordion-title').siblings('.accordion-content');
    if (accordion_content.hasClass('d-none')) {
      accordion_content.removeClass('d-none');
      $(this).find('a i').removeClass('fa-angle-down').addClass('fa-angle-up');
    } else {
      accordion_content.addClass('d-none');
      $(this).find('a i').removeClass('fa-angle-up').addClass('fa-angle-down');
    }
  });

  if ($('#myinput_one').length >= 1) {
    document.querySelector("#myinput_one").oninput = function() {
      var value = (this.value-this.min)/(this.max-this.min)*100
      this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
    };
  }

  if ($('#myinput_two').length >= 1) {
    document.querySelector("#myinput_two").oninput = function() {
      var value = (this.value-this.min)/(this.max-this.min)*100
      this.style.background = 'linear-gradient(to right, #000 0%, #000 ' + value + '%, #F3F5FA ' + value + '%, #F3F5FA 100%)'
    };
  }
});


document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '.faded-popover-wrapper .faded-popover-title', function() {
    $('.faded-popover-wrapper .faded-popover-content').addClass('d-none');
    $('.faded-popover-wrapper .faded-popover-title .faded-popover-expandable-text').removeClass('faded-popover-expand-text');
    $(this).siblings('.faded-popover-content').removeClass('d-none');
    $(this).find('.faded-popover-expandable-text').addClass('faded-popover-expand-text');
  });

  $('body').on('click', '.faded-popover-wrapper .faded-popover-content .faded-popover-close', function() {
    $(this).parents('.faded-popover-content').addClass('d-none');
    $(this).parents('.faded-popover-content').siblings('.faded-popover-title').find('.faded-popover-expandable-text').removeClass('faded-popover-expand-text');
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

  $('body').on('click', '.wait-loader', function() {
    show_loader();
  });

  window.show_loader = function() {
    $('.loader-wrapper').removeClass('d-none');
  }

  window.hide_loader = function() {
    $('.loader-wrapper').addClass('d-none');
  }
});

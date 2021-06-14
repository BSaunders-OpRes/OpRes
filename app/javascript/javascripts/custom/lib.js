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
    if (this.tagName == 'INPUT' && !$(this).parents('form')[0].checkValidity()) {
      return
    }
    
    show_loader();
  });

  window.show_loader = function() {
    $('.loader-wrapper').removeClass('d-none');
  }

  window.hide_loader = function() {
    $('.loader-wrapper').addClass('d-none');
  }

  $('#dynamic-steps-block').on('cocoon:after-insert', function(e, insertedItem) {
    new_elem    = $(this).find('.nested-fields').last()
    new_elem_modal = $(this).find('.modal').last()
    step_number = $(this).find('.nested-fields').length
    id = insertedItem.find('.step-fields').first().attr('id').split('_').slice(-2)[0]

    new_elem.find('#step-number').text('Step ' + step_number)
    new_elem.find('.toggle-modal').attr('data-target', '#new_supplier_modal_' + step_number)
    new_elem_modal.find('#modal-step-number').text('add supplier to step ' + step_number)
    new_elem_modal.attr('id', 'new_supplier_modal_' + step_number)

    insertedItem.find('.supplier-selector').attr('name', 'business_service_line[steps_attributes][' + id + '][supplier_ids][]')
    insertedItem.find('.critical-radio').attr('id', 'critical-' + step_number)
    insertedItem.find('.critical-label').attr('for', 'critical-' + step_number)
    insertedItem.find('.important-radio').attr('id', 'important-' + step_number)
    insertedItem.find('.important-label').attr('for', 'important-' + step_number)
    insertedItem.find('.supplier-selector').attr('id', 'supplier-selector-' + step_number)
    insertedItem.find('.supplier_form_submit_btn').attr('data-stepid', step_number)
    insertedItem.find('.supplier-selector').select2();
  });

  $( ".supplier-selector" ).select2();
});

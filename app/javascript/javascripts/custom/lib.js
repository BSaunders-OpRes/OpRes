document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '.other-reason-selection', function() {
    if($(this).is(':checked') && $(this).val() == 'other') {
      $('.other-reason-field').removeClass('disable').val('');
    } else {
      $('.other-reason-field').addClass('disable').val('');
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

  $('.select2').select2();

  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy'
  });
});

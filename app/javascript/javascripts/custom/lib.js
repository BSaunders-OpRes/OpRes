document.addEventListener('turbolinks:load', function() {
  /******************** Other Field Enable/Disable Template ********************
    <div class="other-reason-container">
      <label class="radio-check">
        <input id="radio" class="other-reason-selection" type="radio" value="radio" name="radio">
        <label for="radio">radio</label>
        <div class="checkmark position-relative order-1"></div>
      </label>
      <input class="other-reason-field" type="text" value="" name="other">
    </div>
  *****************************************************************************/
  $('body').on('click', '.other-reason-container .other-reason-selection', function() {
    if($(this).is(':checked') && $(this).val() == 'other') {
      $(this).parents('.other-reason-container').find('.other-reason-field').removeClass('disable').val('');
    } else {
      $(this).parents('.other-reason-container').find('.other-reason-field').addClass('disable').val('');
    }
  });

  /******************** Page Loader ********************
  *****************************************************/
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

  /******************** Select 2 ********************
  **************************************************/
  window.init_select2 = function() {
    $('.select2').select2({
      placeholder: 'Please select'
    });
  }
  init_select2();

  /******************** Date Picker ********************
  ******************************************************/
  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy'
  });
});

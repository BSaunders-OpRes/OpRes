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

  /******************** Expand To Full Screen Template ********************
    <div class="expand-to-full-screen">
      <button class="expand-to-full-screen-btn">
        <i class="fa fa-expand"></i>
        <span>Expand</span>
      </button>
      <div>
        content
      </div>
    </div>
  ************************************************************************/
  $('body').on('click', '.expand-to-full-screen-btn', function() {
    if ($(this).hasClass('expanded')) {
      document.exitFullscreen;
      document.exitFullscreen();

      $(this).find('i').removeClass('fa-compress').addClass('fa-expand');
      $(this).find('span').text('Expand');

      $(this).removeClass('expanded');
    } else {
      section = $(this).parents('.expand-to-full-screen');
      section[0].requestFullscreen;
      section[0].requestFullscreen();

      $(this).find('i').removeClass('fa-expand').addClass('fa-compress');
      $(this).find('span').text('Back');

      $(this).addClass('expanded');
    }

    $('html, body').animate({
      'scrollTop' : $(this).parents('.expand-to-full-screen').parent().position().top
    });
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

  window.select2_choose_option = function(field, id) {
    current_vals = field.val();
    current_vals.push(id);
    field.val(current_vals);
    field.select2().trigger('change');
  }

  window.select2_remove_option = function(field, id) {
    current_vals = field.val();
    current_vals.splice(current_vals.indexOf(id), 1);
    field.val(current_vals);
    field.select2().trigger('change');
  }

  init_select2();

  /******************** Date Picker ********************
  ******************************************************/
  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy'
  });

  /******************** Form Vamoose ********************
  ******************************************************/
  window.bind_vamoose = function() {
    window.onbeforeunload = function() {
      return ''
    }
  }

  window.unbind_vamoose = function() {
    window.onbeforeunload = null;
  }

  $('body').on('change', '.vamoose input, .vamoose select', function() {
    bind_vamoose();
  });

  $('body').on('keyup', '.vamoose input, .vamoose textarea', function() {
    bind_vamoose();
  });

  $('body').on('submit', 'form.vamoose', function() {
    unbind_vamoose();
  });
});

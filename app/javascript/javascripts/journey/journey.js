document.addEventListener('turbolinks:load', function() {
  if ($('#onboarding-finish').length >0) {
    setTimeout(function() {
      window.location.href = '/organisation/dashboard';
    }, 2000);
  }

  $('body').on('click', '.build-institution', function() {
    link              = $(this);
    institution_block = link.parents('.institution-block');
    institution_index = institution_block.find('.card').length;

    $.ajax({
      url:  link.data('target'),
      type: 'GET',
      data: {
        institution: link.data('institution'),
        index:       institution_index
      }
    });
  });

  $('body').on('click', '.build-user-invitation', function() {
    link         = $(this);
    invite_index = $('#user-invitation .user-invitation-child').length

    $.ajax({
      url:  link.data('target'),
      type: 'GET',
      data: {
        index: invite_index
      }
    });
  });

  $('body').on('click', '#select-all-countries', function() {
    if(this.checked) {
      $('#countries-partial .country').prop('checked', true);
    } else {
      $('#countries-partial .country').prop('checked', false);
    }
  });

  $('body').on('keypress', '#country-setup-form', function(e) {
    if (e.keyCode == 13) {
      return false;
    }
  });

  $('body').on('keyup', '#country-search-filter', function() {
    var value = $(this).val().toLowerCase();
    $('#countries-partial .country-list').filter(function(index, ele) {
      $(this).toggle($(ele).text().toLowerCase().indexOf(value) > -1)
    });
  });

  $('body').on('click', '.invite-user-step-next', function() {
    $('#invite-user-tabs #send-invitation').click();
  });

  $('body').on('click', '#journey-save-exit-institutions', function() {
    form = $(this).parents('form');
    action = form.attr('action').replace('invite_user', 'country_setup');
    form.attr('action', action);
    $('#journey-submit-institutions').click();
  });

  $('body').on('click', '#journey-save-exit-countries', function() {
    form = $(this).parents('form');
    action = form.attr('action').replace('country_setup', 'account_setup');
    form.attr('action', action);
    $('#journey-submit-countries').click();
  });
});

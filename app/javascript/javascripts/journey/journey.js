document.addEventListener('turbolinks:load', function() {
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

  if ($('#onboarding-finish').length >0) {
    setTimeout(function() {
      window.location.href = '/organisation/dashboard';
    }, 2000);
  }

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
});

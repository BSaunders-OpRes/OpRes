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
});

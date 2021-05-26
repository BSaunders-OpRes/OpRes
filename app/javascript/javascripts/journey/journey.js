document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '.build-institution', function() {
    link              = $(this);
    institution_block = link.parents('.institution-block');
    institution_index = institution_block.find('.card').length;

    $.ajax({
      url: link.data('target'),
      type: 'GET',
      data: {
        institution: link.data('institution'),
        index:       institution_index
      }
    });
  });
});

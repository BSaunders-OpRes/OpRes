document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '.supplier-contracting-term', function() {
    if($('#contracting_termsother').is(':checked')) {
      $('.contracting-term-other-field').removeClass('disable').val('');
    } else {
      $('.contracting-term-other-field').addClass('disable').val('');
    }
  });
});

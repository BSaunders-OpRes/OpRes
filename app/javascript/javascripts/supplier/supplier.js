document.addEventListener('turbolinks:load', function() {
  /******************** Page Load Logics ********************
  **********************************************************/
  $('#supplier-key-contact-select2')
  .select2()
  .on('select2:open', function() {
    $('.select2-results:not(:has(a))').append('<a href="javascript:void(0);" id="supplier-key-contact-new" class="btn p-1 btn-sm primary-btn m-1 pull-right">New contact</a>');
  });

  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('click', '#supplier-key-contact-new', function(e) {
    $('#supplier-key-contact-select2').select2();
    $.ajax({
      url:  '/organisation/key_contacts/new',
      type: 'GET',
      dataType: 'script'
    });
  });
});

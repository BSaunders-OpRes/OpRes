document.addEventListener('turbolinks:load', function() {
  /******************** Event Bindings ********************
  ********************************************************/
  $('body').on('click', '.empty-input-field', function (){
    $(this).parents('.table-search-field').find('input').val('')
});

function search_data(url) {
    $.ajax({
      url:      url,
      dataType: 'script',
      type:     'GET',
      data: {
        query: ''
      }
    });
  }
});




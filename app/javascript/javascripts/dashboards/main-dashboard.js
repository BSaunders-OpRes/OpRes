document.addEventListener('turbolinks:load', function() {
  $('body').on('change', '.regions,.countries,.institutions,.products,.sub-regions,.entities,.party_types,.bsls', function(e) {
    $(".loader-wrapper").removeClass("d-none");
    $('body').addClass("overflow-hidden");
    if(e.target.className.includes('regions')){
      if(e.target.id == 'region-all'){
        $('.regions').prop("checked", e.target.checked);
        $('.regions-count').text(e.target.checked ? $('.regions').length-1 : 0);
      }else{
        $('.regions-count').text($('.regions:checked').length);
      }
    }
    if(e.target.className.includes('countries')){
      if(e.target.id == 'country-all'){
        $('.countries').prop("checked", e.target.checked);
        $('.countries-count').text(e.target.checked ? $('.countries').length-1 : 0);
      }else{
        $('.countries-count').text($('.countries:checked').length);
      }
    }
    if(e.target.className.includes('institutions')){
      if(e.target.id == 'institution-all'){
        $('.institutions').prop("checked", e.target.checked);
        $('.institutions-count').text(e.target.checked ? $('.institutions').length-1 : 0);
      }else{
        $('.institutions-count').text($('.institutions:checked').length);
      }
    }
    if(e.target.className.includes('sub-regions')){
      if(e.target.id == 'sub-region-all'){
        // $('.sub-regions').prop("checked", e.target.checked);
        $('.sub-region-count').text(e.target.checked ? $('.sub-regions').length-1 : 0);
      }else{
        $('.sub-region-count').text($('.sub-regions:checked').length);
      }
    }
    if(e.target.className.includes('products')){
      if(e.target.id == 'product-all'){
        $('.products').prop("checked", e.target.checked);
        $('.products-count').text(e.target.checked ? $('.products').length-1 : 0);
      }else{
        $('.products-count').text($('.products:checked').length);
      }
    }
    if(e.target.className.includes('party_types')){
      if(e.target.id == 'party-types-all'){
        // $('.products').prop("checked", e.target.checked);
        $('.party-types-count').text(e.target.checked ? $('.party_types').length-1 : 0);
      }else{
        $('.party-types-count').text($('.party_types:checked').length);
      }
    }
    if(e.target.className.includes('bsls')){
      if(e.target.id == 'bsl-all'){
        $('.bsls').prop("checked", e.target.checked);
        // $('.bsls').text(e.target.checked ? $('.party_types').length-1 : 0);
      }
    }
  });

  window.selectCall = function(){
    if(!this.event.target.checked){
      $(`.${this.event.target.className.split(" ").pop()}`).prop("checked", false);
    }
  }

  $('#select_item').autocomplete({
    minLength: 2,
    source: "/organisation/dashboard/search"
  }).data("ui-autocomplete")._renderItem = function( ul, item ){
    $('.ui-helper-hidden-accessible').remove();
    var ulElement = $('.ui-autocomplete');
    ulElement.appendTo('.search-field');
    $(".ui-menu").css({"overflow-y":"scroll", "max-height": "250px"});
    return (
      $( "<li class='py-2'></li>" ).data("item.autocomplete", item.name).append(`<a href='${item.url}'>` + item.name + "</a>").appendTo(ul)
    )
  };

  $('body').on('focus', '#select_item', function(e) {
    if($('.ui-autocomplete')){
      $('.ui-autocomplete').show();
    }
  });

  $("#select_item").on( "autocompleteselect", function( event, ui ) {
    $('#select_item').val(ui.item.name);
    $.ajax({
      url:      '/organisation/search_histories',
      dataType: 'json',
      type:     'POST',
      async:     false,
      data: {
        key: ui.item.name,
        url: ui.item.url
      },
      success: function(result){
        // window.open(ui.item.url, '_blank');
        location.href = ui.item.url;
      }
    });
    return false;
  });

  $("#select_item").on( "autocompleteopen", function( event, ui ) {
    $.ajax({
      url:      '/organisation/search_histories',
      dataType: 'json',
      type:     'GET',
      async:     false,
      success: function(result){
        let newUl = $('<ul class="list-unstyled search-history"></ul>');
        $("<p class='text-capitalize font-12'>recent searches</p>").insertAfter('.ui-autocomplete li:last');
        $('<p class="text-capitalize font-12">matches</p>').insertBefore('.ui-autocomplete li:first');
        result.forEach((item, index) => newUl.append(`<li class="searched-li py-2 ${index > 4 ? 'd-none' : 'd-block'}">` + `<a href='${item.url}'>${item.title}</a>` + "</li>"))
        $('.ui-autocomplete').append(newUl);
        if(result.length > 4){
          $('.ui-autocomplete').append('<a class="view-all text-capitalize text-center font-12 py-2 d-block border-top"><span class="text-dark text-decoration-none cursor-pointer border-bottom-black">View All</span></a>');
        }
        // window.open(ui.item.url, '_blank');
        // location.href = ui.item.url;
      }
    });
    return false;
  });

  $('body').on('click', '.view-all', function(){
    $('.searched-li').addClass('d-bock');
    $('.searched-li').removeClass('d-none');
    $('.view-all').addClass('d-none');
    $('.view-all').removeClass('d-block');
  });
});

document.addEventListener('turbolinks:load', function() {
  $('body').on('change', '.regions,.countries,.institutions,.products,.sub-regions,.entities,.party_types', function(e) {
    $(".loader-wrapper").removeClass("d-none");
    $('body').addClass("overflow-hidden");
    if(e.target.className.includes('regions')){
      if(e.target.id == 'region-all'){
        // $('.regions').prop("checked", e.target.checked);
        $('.regions-count').text(e.target.checked ? $('.regions').length-1 : 0);
      }else{
        $('.regions-count').text($('.regions:checked').length);
      }
    }
    if(e.target.className.includes('countries')){
      if(e.target.id == 'country-all'){
        // $('.countries').prop("checked", e.target.checked);
        $('.countries-count').text(e.target.checked ? $('.countries').length-1 : 0);
      }else{
        $('.countries-count').text($('.countries:checked').length);
      }
    }
    if(e.target.className.includes('institutions')){
      if(e.target.id == 'institution-all'){
        // $('.institutions').prop("checked", e.target.checked);
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
        // $('.products').prop("checked", e.target.checked);
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
    // if(e.target.className.includes('entities')){
    //   if(e.target.id == 'entity-all'){
    //     // $('.entities').prop("checked", e.target.checked);
    //     $('.entities-count').text(e.target.checked ? $('.entities:checked').length-1 : $('.entities:checked').length);
    //   }else{
    //     $('.entities-count').text($('.entities:checked').length);
    //   }
    // }
  });

  window.selectCall = function(){
    if(!this.event.target.checked){
      $(`.${this.event.target.className.split(" ").pop()}`).prop("checked", false);
    }
  }
});

document.addEventListener('turbolinks:load', function() {
  /******************** Event Bindings ********************
  ********************************************************/
  // $(window).scroll(function() {
  //   var hT = $('#section3').offset().top,
  //     hH = $('#section3').outerHeight(),
  //     wH = $(window).height(),
  //     wS = $(this).scrollTop();
    
  //   if (wS > (hT+hH-wH)){
  //      render_cloud_critical_system()
  //   }
  // });
  $('body').on('mouseover', '#section3', function(){

  })

});

function render_cloud_critical_system() {
  $.ajax({
    url:      '/organisation/administration_portal',
    dataType: 'script',
    type:     'GET',
    data: {
    
    }
  });
}

document.addEventListener('turbolinks:load', function() {
  $('body').on('change', '#dropdownMenuSupplierType input[type="checkbox"]', function(e) {
    console.log("I am here");
    e.preventDefault();
    // if ( $('#supplierOverview').is(":hidden") ) {
    //   $('#supplierOverview').show()  
    // } else {
    //   $('#supplierOverview').hide()
    // }

    $('#supplierOverview').toggle()
    
  });
});

document.addEventListener('turbolinks:load', function() {

  $('#bsl-tab li').click(function() {
    href  = $(this).find('a').attr('href');
    parts = href.split('-');
    parts.splice(-1);
    parts.push('desc');
    desc = parts.join('-');

    $('#bsl-desc p').addClass('d-none');
    $(desc).removeClass('d-none');
  });

  $('#bsl-proceed-btn').click(function(e) {
    e.preventDefault();

    var current_tab = $('#bsl-tab li.nav-item a.active').parent('li.nav-item');
    var next_tab    = current_tab.next('li.nav-item');

    if(next_tab.length == 0) {
      return;
    } else {
      $('html, body').animate({ scrollTop: '300px' }, 300);
      next_tab.find('a').trigger('click');
    }
  });

  $('#bsl-previous-btn').click(function(e) {
    e.preventDefault();

    var current_tab  = $('#bsl-tab li.nav-item a.active').parent('li.nav-item');
    var previous_tab = current_tab.prev('li.nav-item');

    if(previous_tab.length == 0) {
      return;
    } else {
      $('html, body').animate({ scrollTop: '300px' }, 300);
      previous_tab.find('a').trigger('click');
    }
  });

  $('body').on('click', '.supplier_form_submit_btn', function(e) {
    e.preventDefault();

    const id = $(this).data('stepid')
    const openedModal = $(this).closest('.modal')
    const name = openedModal.find('#name').val();
    const party_type = openedModal.find('#party_type').val();
    const unit_id = openedModal.find('#supplier_country').val();
    const input_fields = $(this).closest('form').find("input[type=text], select");
    let   status = "Critical";

    if($('#important-' + id).is(':checked'))
      status = "Important";

    $.ajax({
      url:  '/organisation/suppliers/',
      dataType: 'script',
      type: 'POST',
      data: {
        supplier: {
          name,
          party_type,
          unit_id,
          status
        }
      },
      success: function(element){
        const supplier = JSON.parse(element)
        if(supplier){
          const newSupplier = new Option(supplier.resp.name, supplier.resp.id, false, true)
          $('.supplier-selector').append(newSupplier).trigger('change');
          toastr.options = { closeButton: true, progressBar: true }
          toastr.success('Supplier created successfully!')
          input_fields.val("");
        }
      }
    });
  });

  $('body').on('change', '#select_supplier', function(e){
    $.ajax({
      url:  '/organisation/suppliers/' + e.target.value,
      type: 'GET',
      dataType: 'script'
    });
  })

  $('body').on('click', '.delete-supplier', function(e){
    //To delete a supplier from bsl steps
  })
});


document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '.add-contact-form-submit-btn', function(e) {
    e.preventDefault();
    var opened_modal = $(this).parents('.modal.add-contact-modal.show');

    $.ajax({
      url:  '/organisation/key_contacts/',
      dataType: 'script',
      type: 'POST',
      data: {
        key_contact: {
          name:         opened_modal.find("input[name='contact[name]']").val(),
          email:        opened_modal.find("input[name='contact[email]']").val(),
          job_title:    opened_modal.find("input[name='contact[job_title]']").val()
        }
      },
      success: function(element) {
        var key_contact     = JSON.parse(element);
        var opened_modal = $('.modal.add-contact-modal.show');

        toastr.options = { closeButton: true, progressBar: true }

        if (key_contact.errors) {
          key_contact.errors.forEach(function(error, index) {
            toastr.error(error)
          });
        } else {
          var new_key_contact = new Option(key_contact.resp.name, key_contact.resp.id, false, false);
          $('.supplier-key-contact-field supplier-key-contact-selector').append(new_key_contact).trigger('change');
          var current_key_contact_selector = opened_modal.find('.supplier-key-contact-selector');
          var current_key_contact_values   = current_key_contact_selector.val();
          current_key_contact_values.push(key_contact.resp.id);
          current_key_contact_selector.val(current_key_contact_values);
          current_key_contact_selector.select2().trigger('change');
          opened_modal.find(":input[name^='key_contact']").val('');
          toastr.success('Key Contact created successfully!');
        }
      }
    });
  });

  $('.datepicker').datepicker({
    format: "dd/mm/yyyy"
  });
});

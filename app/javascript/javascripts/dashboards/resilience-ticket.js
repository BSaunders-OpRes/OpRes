document.addEventListener('turbolinks:load', function() {
  $('body').on('click', '.resilience-audit-new', function(e) {
    resilience_ticket_id = $(this).attr('data-resilience');
    resilience_status = $('#resilience_status').find(':selected').text();
    add_attachment    =  $(this).attr('data-attachment-update');
    $.ajax({
      url:      `/organisation/resilience_tickets/${resilience_ticket_id}/resilience_gaps/new`,
      dataType: 'script',
      type:     'GET',
      async:     false,
      data:     {
        id: resilience_ticket_id,
        resilience_status: resilience_status,
        add_attachment: add_attachment
      }
    });
  });

  $('body').on('change', '.resilience-status', function(e) {
    selected_status = $(this).find(':selected').val();
    resilience_ticket_id = $('.resilience-audit-new').attr('data-resilience');
    resilience_status = $('#resilience_status').find(':selected').text();
    $.ajax({
      url:      `/organisation/resilience_tickets/${resilience_ticket_id}/resilience_gaps/new`,
      dataType: 'script',
      type:     'GET',
      async:     false,
      data:     {
        id:     resilience_ticket_id,
        status: selected_status,
        resilience_status: resilience_status
      }
    });
  });

  $('body').on('change', '.resilience-user', function(e) {
    resilience_assignee_email = $(this).find(':selected').attr('data-email');
    $('#resilience-assignee-email').text(resilience_assignee_email);
  });
});

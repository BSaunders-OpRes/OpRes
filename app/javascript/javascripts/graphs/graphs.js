document.addEventListener('turbolinks:load', function() {
  if ($('.lazy-graph').length >= 1) {
    setTimeout(function() {
      $('.lazy-graph').each(function() {
        $.ajax({
          url:      '/organisation/graphs/compose',
          dataType: 'script',
          type:     'GET',
          async:     false,
          data:     {
            key:            $(this).data('key'),
            args:           $(this).data('args'),
            data_append_to: $(this).data('append-to'),
            partial_name:   $(this).data('partial-name'),
            filters:        $(this).data('filters')
          }
        });
      });
    }, 500)
  }
});


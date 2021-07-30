document.addEventListener('turbolinks:load', function() {
  /******************** Lazy Graph Template ********************
    <div id="key-of-graph" class="lazy-graph" data-key="key_of_graph" data-args="<%= { k1: v1, k2: v2 }.to_json %>" data-append-to="id-of-current-div" data-partial-name="partial name">
      <%= render 'organisation/graphs/partials/key_of_graph', data: {} %>
    </div>
  *************************************************************/
  if ($('.lazy-graph').length >= 1) {
    $('.lazy-graph').each(function() {
      $.ajax({
        url:      '/organisation/graphs/compose',
        dataType: 'script',
        type:     'GET',
        data:     {
          key:            $(this).data('key'),
          args:           $(this).data('args'),
          data_append_to: $(this).data('append-to'),
          partial_name:   $(this).data('partial-name')
        }
      });
    });
  }
});

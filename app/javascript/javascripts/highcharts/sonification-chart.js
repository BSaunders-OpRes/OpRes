document.addEventListener('turbolinks:load', function() {
  if ($('#cloud-service-provider').length == 1) {
    render_line_chart('first-line-chart');
    render_line_chart('second-line-chart');
    render_line_chart('third-line-chart');
    render_line_chart('fourth-line-chart');
  }

  function render_line_chart(element) {
    var colors = Highcharts.getOptions().colors;

    Highcharts.chart(element, {
      chart: {
        type: 'spline'
      },

      legend: {
        visible: false
      },


      tooltip: {
        valueSuffix: '%'
      },

      plotOptions: {
        series: {
          point: {
            events: {
              click: function () {
                window.location.href = this.series.options.website;
              }
            }
          },
          cursor: 'pointer'
        }
      },

      series: [
      {
        name: '',
        data: [34.8, 43.0, 51.2, 41.4, 64.9, 72.4],
        website: 'https://www.nvaccess.org',
        color: colors[2],
        accessibility: {
          description: 'This is the most used screen reader in 2019'
        }
      }
      ],

      responsive: {
        rules: [{
          condition: {
            maxWidth: 550
          },
          chartOptions: {
            chart: {
              spacingLeft: 3,
              spacingRight: 3
            },
            legend: {
              visible: false
            },
            xAxis: {
              visible: false
            },
            yAxis: {
              visible: false
            }
          }
        }]
      }
    });
  }
});

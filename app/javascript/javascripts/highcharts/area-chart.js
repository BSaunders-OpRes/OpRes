document.addEventListener('turbolinks:load', function() {
  if ($('#area-chart').length == 1) {
    render_area_chart('area-chart');
  }

  function render_area_chart(element) {
    Highcharts.chart(element, {
      chart: {
        type: 'area',
        plotBorderWidth: 1,
      },
      title: {
        text: ''
      },
      subtitle: {
        text: ''
      },
      xAxis: {
        categories: ['1 Jan 2021', '1 Feb 2021', '1 Mar 2021', '1 Apr 2021', '1 May 2021'],
        tickmarkPlacement: 'off',
        title: {
          enabled: false
        }
      },
      yAxis: {
        title: {
          text: 'Number of Vulnerablities'
        },
        labels: {
          formatter: function () {
            return this.value / 100;
          }
        }
      },
      tooltip: {
        split: true,
        valueSuffix: ' millions'
      },
      plotOptions: {
        area: {
          stacking: 'normal',
          lineColor: '#666666',
          lineWidth: .5,
          marker: {
            lineWidth: .5,
            lineColor: '#303030'
          }
        }
      },
      series: [{
        name: 'Critical',
        data: [1000, 900, 809, 947, 1402, 30],
        color: 'rgba(233,252,247,.7)'
      }, {
        name: 'Important',
        data: [1000, 900, 809, 133, 221, 50],
        color: '#D1E2DE'
      }]
    });
  }
});
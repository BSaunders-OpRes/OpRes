document.addEventListener('turbolinks:load', function() {
  if ($('#system-supplier-resilience-indicator').length == 1) {
    render_donut_chart('colored-donut');
  }

  function render_donut_chart(element) {
    Highcharts.chart(element, {
      chart: {
        margin: [0, 0, 0, 0],
        spacingTop: 0,
        spacingBottom: 0,
        spacingLeft: 40,
        spacingRight: 40,
        plotBackgroundColor: null,
        plotBackgroundImage: null,
        plotBorderWidth: 0,
        plotShadow: false,
        backgroundColor: 'transparent',
        credits: false
      },
      title: {
        text: '',
        align: 'center',
        verticalAlign: 'middle',
        y: 20
      },
      tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      },
      accessibility: {
        point: {
          valueSuffix: '%'
        }
      },
      plotOptions: {
        pie: {
          dataLabels: {
            enabled: true,
            distance: -50,
            style: {
              fontWeight: 'bold',
              color: 'white'
            }
          },
          startAngle: 90,
          endAngle: 90,
          center: ['50%', '50%'],
          pointPadding: 0,
        }
      },
      series: [{
        type: 'pie',
        name: 'Browser share',
        innerSize: '80%',
        groupPadding: 0,
        data: [
          {
            name: '',
            y: 40,
            color: '#E4412E'
          },
          {
            name: '',
            y: 50,
            color: '#6BEAB3'
          },
          {
            name: '',
            y: 10,
            color: '#E39A2B'
          }
        ]
      }]
    });
  }
});

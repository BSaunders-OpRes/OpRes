document.addEventListener('turbolinks:load', function() {
  if ($('#management-dashboard').length == 1) {
    render_donut('first-donut');
    render_donut('second-donut');
    render_donut('third-donut');
    render_donut('fourth-donut');
  }

  function render_donut(element) {
    Highcharts.chart(element, {
      chart: {
        renderTo: 'container',
        plotBackgroundColor: null,
        plotBackgroundImage: null,
        plotBorderWidth: 0,
        plotShadow: false,
        backgroundColor: 'transparent',
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
          center: ['50%', '45%'],
          size: '90%',
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
            color: '#6BEAB3'
          },
          {
            name: '',
            y: 50,
            color: '#367C5C'
          },
          {
            name: '',
            y: 10,
            color: '#CDFAF1'
          }
        ]
      }]
    });
  }
});

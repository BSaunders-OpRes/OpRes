document.addEventListener('turbolinks:load', function() {
  if ($('#management-dashboard').length == 1) {
    render_semi_donut('semi-donut-1', '#E4412E');
    render_semi_donut('semi-donut-2', '#FFD730');
    render_semi_donut('semi-donut-3', '#E39A2B');
    render_semi_donut('semi-donut-4', '#6BEAB3');

  }

  function render_semi_donut(element, color) {
    Highcharts.chart(element, {
      chart: {
        plotBorderWidth: 0,
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
        text: ''
      },
      tooltip: {
        pointFormat: '<b>{point.percentage:.1f}%</b>'
      },
      plotOptions: {
        pie: {
          dataLabels: {
            enabled: true,
            distance: -50,
            style: { fontWeight: 'bold', color: 'white' }
          },
          startAngle: -90,
          endAngle: 90,
          center: ['50%', '50%'],
          pointPadding: 0,
        }
      },
      series: [
        {
          type: 'pie',
          name: '',
          innerSize: '70%',
          data: [
            {
              name: '',
              y: 76.1,
              color: color
            },
            {
              name: '',
              y: 23.9,
              color: '#dddddd'
            }
          ]
        }
      ],
      credits: {
        enabled: false
      },
      exporting: {
        enabled: true,
      }
    });
  }
});

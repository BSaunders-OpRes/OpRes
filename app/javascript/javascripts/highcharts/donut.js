document.addEventListener('turbolinks:load', function() {
  if ($('#management-dashboard').length == 1) {
    render_donut_chart('first-donut');
    render_donut_chart('second-donut');
    render_donut_chart('third-donut');
    render_donut_chart('fourth-donut');
    render_donut_chart('fifth-donut');
    render_donut_chart('sixth-donut');
    render_donut_chart('seventh-donut');
    render_donut_chart('first-donut-sm');
    render_donut_chart('second-donut-sm');
    render_donut_chart('third-donut-sm');
    render_donut_chart('fourth-donut-sm');
    render_donut_chart('fifth-donut-sm');
    render_donut_chart('sixth-donut-sm');
    render_donut_chart('seventh-donut-sm');
    render_donut_chart('eight-donut-sm');
    render_donut_chart('ninth-donut-sm');
    render_donut_chart('tenth-donut-sm');
    render_donut_chart('eleventh-donut-sm');
    render_donut_chart('twelth-donut-sm');
  }
  if ($('#cirtical-important-system').length == 1) {
    render_donut_chart('thirteen-donut-sm');
    render_donut_chart('forteen-donut-sm');
  }

  if ($('#business-service-tiers').length == 1) {
    render_donut_chart('thirteen-donut');
    render_donut_chart('fourteen-donut');
  }

  if ($('#cloud-service-provider').length == 1) {
    render_donut_chart('fifteen-donut');
    render_donut_chart('sixteen-donut');
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
        innerSize: '70%',
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

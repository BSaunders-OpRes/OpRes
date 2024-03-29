document.addEventListener('turbolinks:load', function() {
  if ($('#system-supplier-resilience-indicator').length == 1) {
    render_donut_chart('colored-donut');
    render_donut_chart('colored-donut-resilience-posture');
  }
  if ($('#compounded-resilience-posture').length == 1) {
    render_donut_chart('colored-donut-resilience-posture');
  }


  if ($('#bsl').length == 1) {
    render_donut_chart('colored-donut-1');
    render_donut_chart('colored-donut-2');
    render_donut_chart('colored-donut-3');
  }

  if ($('#resilience-calculator').length == 1) {
    render_donut_chart('colored-donut-1');
    render_donut_chart('colored-donut-2');
    render_donut_chart('colored-donut-3');
    render_two_colored_donut_chart('colored-donut-4');
    render_colored_donut_chart('colored-donut-5');
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
        innerSize: '75%',
        groupPadding: 0,
        data: [
          {
            name: '',
            y: 0,
            color: '#E4412E'
          },
          {
            name: '',
            y: 0,
            color: '#6BEAB3'
          },
          {
            name: '',
            y: 0,
            color: '#E39A2B'
          }
        ]
      }]
    });
  }

  function render_two_colored_donut_chart(element) {
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
          startAngle: 0,
          endAngle: 360,
          center: ['50%', '50%'],
          pointPadding: 0,
        }
      },
      series: [{
        type: 'pie',
        name: 'Browser share',
        innerSize: '75%',
        groupPadding: 0,
        data: [
          {
            name: '',
            y: 0,
            color: '#6BEAB3'
          },
          {
            name: '',
            y: 0,
            color: '#E4412E'
          }
        ]
      }]
    });
  }

  function render_colored_donut_chart(element) {
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
          startAngle: 0,
          endAngle: 360,
          center: ['50%', '50%'],
          pointPadding: 0,
        }
      },
      series: [{
        type: 'pie',
        name: 'Browser share',
        innerSize: '75%',
        groupPadding: 0,
        data: [
          {
            name: '',
            y: 0,
            color: '#E4412E'
          },
          {
            name: '',
            y: 0,
            color: '#E39A2B'
          },
          {
            name: '',
            y: 0,
            color: '#6BEAB3'
          },
          {
            name: '',
            y: 0,
            color: '#367C5C'
          },
          {
            name: '',
            y: 0,
            color: '#c363ff'
          },
          {
            name: '',
            y: 0,
            color: '#418dff'
          },
          {
            name: '',
            y: 0,
            color: '#965b00'
          },
          {
            name: '',
            y: 0,
            color: '#CDFAF1'
          },
          {
            name: '',
            y: 0,
            color: '#717070'
          },
          {
            name: '',
            y: 0,
            color: '#bbbbbb'
          }
        ]
      }]
    });
  }
});

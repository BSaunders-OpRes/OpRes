document.addEventListener('turbolinks:load', function() {
  if ($('#container-speed').length == 1) {
    render_semi_donut('container-speed');
  }

  function render_semi_donut(element) {
    Highcharts.chart(element, {
      chart: {
        type: 'solidgauge',
        backgroundColor: "#ffffff",
        height: 220,
      },
      title: {
        text: "Audites",
        align: "left",
        style: {
          padding: "10px 0",
          'font-size': "14px !important",
          'font-weight': "400",
          color: "#3c3c3c",
          'line-height': "16px",
          'font-family': "'Open Sans', sans-serif !important;",
          'border-bottom': "1px solid #eeeeee"
        },
      },
      pane: {
        center: ['50%', '85%'],
        size: '120%',
        startAngle: -90,
        endAngle: 90,
        background: {
          backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
          innerRadius: '60%',
          outerRadius: '100%',
          shape: 'arc'
        }
      },
      tooltip: {
        enabled: false
      },
      yAxis: {
        stops: [
          [0.1, '#547df9'],
          [0.5, '#547df9'],
          [0.9, '#547df9']
        ],
        lineWidth: 1,
        minorTickInterval: null,
        tickAmount: 2,
        title: {
          y: -70
        },
        labels: {
          y: 16
        }
      },
      plotOptions: {
        solidgauge: {
          dataLabels: {
            y: 5,
            borderWidth: 0,
            useHTML: true
          }
        }
      },
      yAxis: {
        min: 0,
        max: 905,
        tickPositions: [0, 905],
        title: {
          text: ''
        }
      },
      credits: {
        enabled: false
      },
      exporting: {
        enabled: true,
      },
      series: [{
        name: '',
        data: [511],
        dataLabels: {
          format: '<div style="text-align:center;"><span style="font-size:30px; font-family: Open Sans; color:' +
            ((Highcharts.theme && Highcharts.theme.contrastTextColor) || '#000000') + '">{y}</span><br/><br/>' +
            '<span style="font-size:13px;font-weight:300; margin-top:20px;color:#000000">As at 21/03/2017</span></div>',
          y: 45,
        },
        tooltip: {
          valueSuffix: ' km/h'
        }
      }]
    });
  }
});

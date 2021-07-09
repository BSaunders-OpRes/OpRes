document.addEventListener('turbolinks:load', function() {
  if ($('#resilience-calculator').length == 1) {
    render_donut_chart('stacked');
  }
  function render_donut_chart(element) {
    Highcharts.chart(element, {
      chart: {
        type: 'bar'
      },
      title: {
        text: 'Stacked bar chart'
      },
      xAxis: {
        categories: ['2016', '2017', '2018', '2019', '2020']
      },
      yAxis: {
        min: 0
      },
      legend: {
        reversed: true
      },
      plotOptions: {
        series: {
          stacking: 'normal'
        }
      },
      series: [{
        name: 'Joe',
        data: [3, 4, 4, 2, 5]
      }]
    });
  };
});
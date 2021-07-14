import React, { useState } from 'react';
import { render }          from 'react-dom';
import Highcharts          from 'highcharts';
import HighchartsReact     from 'highcharts-react-official';

let chartOptions = {
  renderto: '',
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
        enabled: false,
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
    name: '',
    innerSize: '70%',
    groupPadding: 0,
    data: []
  }]
}

export default function donut(props) {
  chartOptions['series'][0]['data'] = props['data'];
  chartOptions['renderto']          = props['render_to'];

  return(
    <div class="w-100">
      <HighchartsReact highcharts={Highcharts} options={chartOptions} />
    </div>
  )
}

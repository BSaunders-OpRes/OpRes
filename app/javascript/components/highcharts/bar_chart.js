import React, { useState } from 'react';
import { render }          from 'react-dom';
import Highcharts          from 'highcharts';
import HighchartsReact     from 'highcharts-react-official';

let chartOptions = {
  chart: {
    type: 'column',
    plotBorderWidth: 1,
  },
 yAxis: {
    title: {
      text: 'Total Count'
    }
  },
  xAxis: {
    title: {
      text: 'Month & Year'
    }
  },
  colors: ['#E4412E', '#E39A2B', '#6BEAB3'],
  tooltip: {
    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
      '<td style="padding:0"><b>{point.y}</b></td></tr>',
    footerFormat: '</table>',
    shared: true,
    useHTML: true
  }
}

export default function bar_chart(props) {
  chartOptions['series'] = props['data'];
  chartOptions['xAxis'] = props['xAxis'];

  return(
    <div className="w-100 position-relative z-index-1">
      <HighchartsReact highcharts={Highcharts} options={chartOptions} />
    </div>
  )
}

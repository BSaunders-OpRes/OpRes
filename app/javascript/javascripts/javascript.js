import JQuery     from 'jquery';
import Highcharts from 'highcharts';
import toastr     from 'toastr';

import './journey/journey';
import './bsl/bsl';
import './unit/unit';
import './custom/custom';
import './custom/lib';
import './graphs/graphs';
import './highcharts/donut';
import './highcharts/semi-donut';
import './highcharts/area-chart';
import './highcharts/colored-donut';

window.$          = JQuery;
window.Highcharts = Highcharts;
window.toastr     = toastr;
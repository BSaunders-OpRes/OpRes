import JQuery     from 'jquery';
import Highcharts from 'highcharts';
import toastr     from 'toastr';
import "bootstrap-datepicker"

import './journey/journey';
import './bsl/bsl';
import './unit_hierarchy/unit_hierarchy';
import './supplier/supplier';
import './custom/custom';
import './custom/lib';
import './graphs/graphs';
import './highcharts/donut';
import './highcharts/semi-donut';
import './highcharts/area-chart';
import './highcharts/colored-donut';
import './highcharts/sonification-chart';

window.$          = JQuery;
window.Highcharts = Highcharts;
window.toastr     = toastr;

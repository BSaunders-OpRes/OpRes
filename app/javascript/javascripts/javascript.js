import JQuery     from 'jquery';
import Highcharts from 'highcharts';
import toastr     from 'toastr';
import Datepicker from 'bootstrap-datepicker';
import Swal       from 'sweetalert2';

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
import './highcharts/stacked-chart';

window.$          = JQuery;
window.Highcharts = Highcharts;
window.toastr     = toastr;
window.Swal       = Swal;

toastr.options = { closeButton: true, progressBar: true }

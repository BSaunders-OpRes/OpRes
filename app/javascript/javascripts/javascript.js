import JQuery     from 'jquery';
import Highcharts from 'highcharts';
import toastr     from 'toastr';
import Datepicker from 'bootstrap-datepicker';
import Swal       from 'sweetalert2';
import IntroJS    from 'intro.js';

import './journey/journey';
import './bsl/bsl';
import './bsl/cloud_hosting_provider';
import './critical_important_system/cis';
import './unit_hierarchy/unit_hierarchy';
import './supplier/supplier';
import './administration_portal/administration_portal';
import './introjs/dashboard';
import './custom/custom';
import './custom/lib';
import './list_directory/list_directory';
import './graphs/graphs';
import './highcharts/donut';
import './highcharts/semi-donut';
import './highcharts/area-chart';
import './highcharts/colored-donut';
import './highcharts/sonification-chart';
import './highcharts/stacked-chart';
import './dashboards/critical-important-system';

window.$          = JQuery;
window.Highcharts = Highcharts;
window.toastr     = toastr;
window.Swal       = Swal;
window.IntroJS    = IntroJS;

toastr.options = { closeButton: true, progressBar: true }

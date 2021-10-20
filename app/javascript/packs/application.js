require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

require('jquery');
require('jquery-validation');
require('popper.js');
require("jquery-ui")
require('bootstrap');
require('@nathanvda/cocoon');
require('select2');
require('toastr');
require('intro.js');
require( 'datatables.net');
require( 'datatables.net-dt');

require.context('../images', true);

import '../javascripts/javascript.js';
import '../stylesheets/stylesheet.scss';

var componentRequireContext = require.context('components', true);
var ReactRailsUJS = require('react_ujs');
ReactRailsUJS.useContext(componentRequireContext);

import Rails from '@rails/ujs';
global.RailsUJS = Rails;
require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

require('jquery');
require('popper.js');
require('bootstrap');
require("@nathanvda/cocoon")
require('select2')
require('toastr')

require.context('../images', true);

import toastr from 'toastr'
import '../javascripts/javascript.js';
import '../stylesheets/stylesheet.scss';

var componentRequireContext = require.context('components', true);
var ReactRailsUJS = require('react_ujs');
ReactRailsUJS.useContext(componentRequireContext);

window.toastr = toastr
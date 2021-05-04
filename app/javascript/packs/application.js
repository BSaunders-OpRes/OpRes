require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

require('jquery');
require('popper.js');
require('bootstrap');
require("jquery-validation")

require.context('../images', true);

import '../javascripts/javascript.js';
import '../stylesheets/stylesheet.scss';

var componentRequireContext = require.context('components', true);
var ReactRailsUJS = require('react_ujs');
ReactRailsUJS.useContext(componentRequireContext);

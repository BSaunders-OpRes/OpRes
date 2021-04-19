import React     from 'react';
import PropTypes from 'prop-types';
import axios     from 'axios';

class csrf extends React.Component {
  static get_csrf_token = () => {
    const token = document.querySelector("meta[name='csrf-token']").getAttribute('content');
    return token;
  }
}

export default csrf;

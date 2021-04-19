import React     from 'react';
import PropTypes from 'prop-types';
import axios     from 'axios';

class headers extends React.Component {
  static get_post_header = (csrf) => {
    let header = {
      headers: {  
        'X-CSRF-Token': csrf
      }
    }
    return header;
  }
}

export default headers;

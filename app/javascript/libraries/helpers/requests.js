import React     from 'react';
import PropTypes from 'prop-types';
import axios     from 'axios';

class requests extends React.Component {
  static post = (url, bodyParam, headersOptions) => {
    return new Promise((resolve, reject) => {
      axios.post(url, bodyParam, headersOptions)
      .then((response) => {
        resolve(response.data);
      })
      .catch((error) => {
        reject(error);
      })
    })
  } 
}

export default requests;

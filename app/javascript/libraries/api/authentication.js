import React     from 'react';
import PropTypes from 'prop-types';
import axios     from 'axios';

import csrf      from '../helpers/csrf';
import headers   from '../helpers/headers';
import requests  from '../helpers/requests';
import { newUserPath, userSigninPath} from '../helpers/constants';

class authentication extends React.Component {
  static login = (user) => {
    const csrf_token     = csrf.get_csrf_token();
    const headersOptions = headers.get_post_header(csrf_token);

    return requests.post(userSigninPath, user, headersOptions);
  }

  static signup = (user) => {
    const csrf_token   = csrf.get_csrf_token();
    let headersOptions = headers.get_post_header(csrf_token);

    return requests.post(newUserPath, user, headersOptions);
  }
}

export default authentication;

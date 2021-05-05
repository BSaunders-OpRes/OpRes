import React, { useState }            from 'react';
import { ToastContainer, toast }      from 'react-toastify';
import { Form, FormCheck, FormLabel } from 'react-bootstrap';
import { AiFillEyeInvisible }         from 'react-icons/ai';
import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom';

import authentication from '../../libraries/api/authentication';
import Carousel       from '../carousel/carousel';
import Logo           from '../../images/logo.png';

export default function login(props) {
  const [email,    setEmail]    = useState('');
  const [password, setPassword] = useState('');
  const [error,    setError]    = useState('');

  const handleSubmit = (e)=> {
    e.preventDefault();
  }

  const error_handling = (err) => {
    toast.error(err.response.data.error, { autoClose:3000 });
  }

  const redirection = (resp) => {
    window.location.href = resp.redirect_url
  }

  const Eye = <i class="fa fa-eye" aria-hidden="true"></i>
  const EyeSlash = <i class="fa fa-eye-slash" aria-hidden="true"></i>;

  return (
    <div className='login-wrapper h-100'>
      <div className='row h-100'>
        <div className="col-md-6">
          <div className='logo-container'>
            <img src={Logo} alt=""/>
          </div>
          <div className='form-wrapper'>
            <h1 className="mb-5 font-600">Forgot Password</h1>
            <div className='input-field'>
              <form className='h-100' onSubmit={handleSubmit}>
                <div className="row">
                  <div className="form-group col-md-10">
                    <input type="email" value={email} name="name" className='form-control border-0' placeholder='Email address' onChange={e => setEmail(e.target.value)} />
                    <div className='error'>{error}</div>
                  </div>
                </div>
                <div className="row">
                  <div className="form-group col-md-10 mb-0">
                    <button className='btn-submit'type="submit" value="Submit">
                      Send
                    </button>
                  </div>
                </div>
                <div className='row'>
                  <div className="col-md-10">
                    <div className='sign-up-text my-4 text-center'>
                    </div>
                    <div className='forget-password-text text-center'>
                    <a href='/users/sign_in' className="ml-2 text-decoration-none">Back to Sign In</a>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        <div className="col-md-6">
          <Carousel/>
        </div>
      </div>
      <ToastContainer />
    </div>
  )
}

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
  const [passwordShown, setPasswordShown] = useState(false);
  const togglePasswordVisiblity = () => {
    setPasswordShown(passwordShown ? false : true);
  };

  function SubmitButton(){
    if (email && password ) {
      return <button type="submit" value="Submit" className='border-0 shadow-sm text-white font-600 rounded bg-primary-green w-100 p-2'>Sign In</button>
    } else {
      return <button type="submit" value="Submit" data-toggle="tooltip" data-placement="top" title="Fill the login form" className='border-0 shadow-sm rounded font-600 btn-submit w-100 p-2' disabled>Sign In</button>
    };
  };
  const handleSubmit = (e)=> {
    e.preventDefault();
    if (email === '' || password === '') {
      setError('Fields are required');
      return;
    }

    const user = { user: { email: email, password: password } };
    authentication.login(user)
    .then(resp => redirection(resp))
    .catch(err => error_handling(err))
  }

  const error_handling = (err) => {
    toast.error(err.response.data.error, { autoClose:5000 });
  }

  const redirection = (resp) => {
    window.location.href = resp.redirect_url
  }

  const eye = <i className="fa fa-eye" aria-hidden="true"></i>
  const eyeSlash = <i className="fa fa-eye-slash" aria-hidden="true"></i>;

  return (
    <div className='login-wrapper h-100'>
      <div className='row h-100'>
        <div className="col-md-6 pr-md-0">
          <div className='form-wrapper'>
            <div className='input-field'>
              <form className='h-100' onSubmit={handleSubmit}>
                <div className="row">
                  <div class="col-md-10 mx-auto">
                    <div class="row">
                      <div className='logo-container col-md-12'>
                        <img src={Logo} alt=""/>
                      </div>
                      <h2 className="mb-4 font-600 col-md-12">Log into your account</h2>
                      <div className="form-group col-md-12 animated-field">
                        <input type="email" value={email} name="name" className='form-control border-0' placeholder='Email address' onChange={e => setEmail(e.target.value)} />
                        <label>Email address</label>
                        <div className='error'>{error}</div>
                      </div>
                      <div className="form-group col-md-12 animated-field password">
                        <input type={passwordShown ? "text" : "password"} value={password} name="name" className='form-control border-0' placeholder='Password' onChange={e => setPassword(e.target.value)} />
                        <label>Password</label>
                         <i onClick={togglePasswordVisiblity}>{passwordShown ? eye : eyeSlash}</i>
                        <div className='error'>{error}</div>
                      </div>
                      <div className='check-box-container col-md-12'>
                        <Form.Group controlId="formBasicCheckbox">
                          <Form.Check className="pl-0" type="checkbox" label="Keep me logged in" />
                        </Form.Group>
                      </div>
                      <div className="form-group col-md-12">
                        <SubmitButton/>
                      </div>
                      <div className='sign-up-text text-center col-md-12'>
                        <p className="mb-3">Dont have an account
                          <a href='/users/sign_up' className="ml-2 text-decoration-none">Sign Up</a>
                        </p>
                      </div>
                      <div className='forget-password-text text-center col-md-12'>
                        <p className="mb-3">
                          <a href='/users/password/new' className="text-decoration-none">Forgot password</a>
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        <div className="col-md-6 pl-md-0 d-none d-md-block">
          <Carousel/>
        </div>
      </div>
      <ToastContainer />
    </div>
  )
}

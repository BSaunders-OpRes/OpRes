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
    if (email === '') {
      setError('Field is required');
      return;
    }
    const user = { user: { email: email } };
    authentication.reset_password(user)
    .then(resp => redirection(resp))
    .catch(err => error_handling(err))
  }

  const error_handling = (err) => {
    toast.error(err.response.data.error, { autoClose:3000 });
  }

  const redirection = (resp) => {
    if (resp){
      toast.success('Request has been sent successfully to your email.', { autoClose:3000 });
    }else{
      toast.error('User not exists', { autoClose:3000 });
    }
  }

  const Eye = <i class="fa fa-eye" aria-hidden="true"></i>
  const EyeSlash = <i class="fa fa-eye-slash" aria-hidden="true"></i>;

  return (
    <div className='login-wrapper h-100'>
      <div className='row h-100'>
        <div className="col-md-6 pr-md-0">
          <div className='form-wrapper'>
            <div className='input-field'>
              <form className='h-100' onSubmit={handleSubmit}>
                <div className="row">
                  <div class="col-md-10 mx-auto">
                    <div className='logo-container'>
                      <img src={Logo} alt=""/>
                    </div>
                    <h2 className="mb-4 font-600">Forgot Password</h2>
                    <div class="row">
                      <div className="form-group col-md-12 animated-field">
                        <input type="email" value={email} name="name" className='form-control border-0' placeholder='Email address' onChange={e => setEmail(e.target.value)} />
                        <label>Email Address</label>
                        <div className='error'>{error}</div>
                      </div>
                    </div>
                    <div className="form-group">
                      <button className='btn-submit w-100 p-2'type="submit" value="Submit">
                        Send
                      </button>
                    </div>
                    <div className='forget-password-text text-center'>
                      <p className="mb-3">
                        <a href='/users/sign_in' className="text-decoration-none">Back to Sign In</a>
                      </p>
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

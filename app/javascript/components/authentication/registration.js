import React, { useState }            from 'react';
import { ToastContainer, toast }      from 'react-toastify';
import { Form, FormCheck, FormLabel } from 'react-bootstrap';
import { AiFillEyeInvisible }         from 'react-icons/ai';
import { Tabs, Tab }                  from 'react-bootstrap';
import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom';

import authentication    from '../../libraries/api/authentication';
import Carousel          from '../carousel/carousel';
import Logo              from '../../images/logo.png';

import { organisationTypes } from '../../libraries/helpers/constants';

export default function Registration() {
  const [email, setEmail]                                 = useState('');
  const [emailError, setEmailError]                       = useState('');
  const [password, setPassword]                           = useState('');
  const [passwordError, setPasswordError]                 = useState('');
  const [organisationName, setorganisationName]           = useState('');
  const [organisationNameError, setorganisationNameError] = useState('');
  const [organisationType, setOrganisationType]           = useState('');
  const [organisationTypeError, setOrganisationTypeError] = useState('');
  const [passwordShown, setPasswordShown]                 = useState(false);

  const togglePasswordVisiblity = () => {
    setPasswordShown(passwordShown ? false : true);
  };
  const handleSubmit = (e)=> {
    e.preventDefault();

    if (email === '') {
      setEmailError('Email is required');
      return;
    } else if (password === '') {
      setPasswordError('Password is required');
      return;
    } else if (organisationName === '') {
      setorganisationNameError('Company name are required');
      return;
    } else if (organisationType === '') {
      setOrganisationTypeError('Organization type is required');
      return;
    }

    const user = { user: { email: email, password: password }, organisation: { name: organisationName, unit_type: organisationType } }
    authentication.signup(user)
    .then(resp => redirection(resp))
    .catch(err => error_handling(err))
  }

  const redirection = (resp) => {
    window.location.href = resp.redirect_url;
    toast.success(resp.message, { autoClose:3000 });
  }

  const error_handling = (err) => {
    toast.error(err.response.data.message, { autoClose:3000 });
  }
  const eye = <i className="fa fa-eye" aria-hidden="true"></i>
  const eyeSlash = <i className="fa fa-eye-slash" aria-hidden="true"></i>;

  return (
    <div className="h-100">
      <div className='row h-100'>
        <div className="col-md-6 pr-md-0">
          <div className='form-wrapper'>
            <form className='h-100' onSubmit = {handleSubmit}>
              <div className="row">
                <div className="col-md-10 mx-auto">
                  <div className="row">
                    <div className='logo-container col-md-12 mt-2'>
                      <img src={Logo} alt=""/>
                    </div>
                    <div className='col-md-12'>
                      <h3 className="font-600 w-100 mt-2 mb-3">Sign Up</h3>
                    </div>
                    <div className="form-group col-md-12 animated-field">
                      <input type="text" name="name" className='form-control border-0' placeholder='First Name' />
                      <label>First Name</label>
                    </div>
                    <div className="form-group col-md-12 animated-field">
                      <input type="text" name="name" className='form-control border-0' placeholder='Last Name' />
                      <label>Last Name</label>
                    </div>
                    <div className="form-group col-md-12 animated-field">
                      <input type="text" name="name" className='form-control border-0' placeholder='Job Title' />
                      <label>Job Title</label>
                    </div>
                    <div className="form-group col-md-12 animated-field">
                      <input type="email" value={email} name="name" className='form-control border-0' placeholder='Email address' onChange={e => setEmail(e.target.value)} />
                      <label>Email address</label>
                      <div className='error'>{emailError}</div>
                    </div>
                    <div className="form-group col-md-12 animated-field password">
                      <input type={passwordShown ? 'text' : 'password'} value={password} name="password" className='form-control border-0' placeholder='Password' onChange={e => setPassword(e.target.value)} />
                      <label>Password</label>
                      <i onClick={togglePasswordVisiblity}>{passwordShown ? eye : eyeSlash}</i>
                      <div className='error'>{passwordError}</div>
                    </div>
                    <div className="form-group col-md-12 animated-field">
                      <input type="text" value={organisationName} name="company_name" className='form-control border-0' placeholder='Organisation Name' onChange={e => setorganisationName(e.target.value)} />
                      <label>Organisation Name</label>
                      <div className='error'>{organisationNameError}</div>
                    </div>
                    <div class="form-group col-md-12">
                      <select className='form-control border-0 signup-select' name="organisationtype" placeholder='Organization Type' onChange={e => setOrganisationType(e.target.value)}>
                        <option value="">Please select organisation type</option>
                        {Object.entries(organisationTypes).map((type) => {
                          return(
                            <option key={type} value={type[0]}>{type[1]}</option>
                          )}
                        )}
                      </select>
                      <i class="fa fa-sort-desc pr-2 mr-2" aria-hidden="true"></i>
                      <div className='error'>{organisationTypeError}</div>
                    </div>
                    <div class="form-group col-md-12">
                      <button type="submit" value="Submit" className='btn-submit w-100 p-2'>
                        Sign Up
                      </button>
                    </div>
                    <div className='sign-up-text text-center col-md-12'>
                      <p className="mb-3">Already have an account
                        <a href='/users/sign_in' className="ml-2 text-decoration-none">Sign In</a>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </form>
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

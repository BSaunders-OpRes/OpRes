import React, { useState }            from 'react';
import { ToastContainer, toast }      from 'react-toastify';
import { Form, FormCheck, FormLabel } from 'react-bootstrap';
import { AiFillEyeInvisible }         from 'react-icons/ai';
import { Tabs, Tab }                  from 'react-bootstrap';
import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom';

import authentication    from '../../libraries/api/authentication';
import Carousel          from '../carousel/carousel';
import Logo              from '../../images/logo.png';
import organisationTypes from '../../libraries/helpers/constants'; 

export default function Registration() {
  const [email, setEmail]                                 = useState('');
  const [emailError, setEmailError]                       = useState('');
  const [password, setPassword]                           = useState('');
  const [passwordError, setPasswordError]                 = useState('');
  const [organisationName, setorganisationName]           = useState('');
  const [organisationNameError, setorganisationNameError] = useState('');
  const [organisationType, setOrganisationType]           = useState('');
  const [organisationTypeError, setOrganisationTypeError] = useState('');

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

  return (
    <div className="h-100">
      <div className='row h-100'>
        <div className="col-md-6">
          <div className='logo-container'>
            <img src={Logo} alt=""/>
          </div>
          <div className='form-wrapper'>
            <h1 className="font-600">Sign Up</h1>
            <div className='form-style'>
              <Tabs defaultActiveKey="customer" id="uncontrolled-tab-example">
              <Tab eventKey="customer" title="Customer Login">
              <div className='input-field'>
                <form className='h-100' onSubmit = {handleSubmit}>
                  <div className="row">
                    <div className="form-group col-md-10">
                      <input type="email" value={email} name="name" className='form-control border-0' placeholder='Email address' onChange={e => setEmail(e.target.value)} />
                      <div className='error'>{emailError}</div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="form-group col-md-10">
                      <div className='password'>
                        <input type="password" value={password} name="password" className='form-control border-0' placeholder='Password' onChange={e => setPassword(e.target.value)} />
                      </div>
                      <div className='error'>{passwordError}</div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="form-group col-md-10">
                      <input type="text" value={organisationName} name="company_name" className='form-control border-0' placeholder='Organization Name' onChange={e => setorganisationName(e.target.value)} />
                      <div className='error'>{organisationNameError}</div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="form-group col-md-10">
                      <select className='form-control border-0 signup-select' name="organisationtype" placeholder='Organization Type' onChange={e => setOrganisationType(e.target.value)}>
                          <option value="">Please select organisation type</option>
                          <option value="retail">Retail</option>
                          <option value="investment">Investment</option>
                          <option value="insurance">Insurance</option>
                          <option value="other">Other</option>
                      </select>
                      <div className='error'>{organisationTypeError}</div>
                    </div>
                  </div>
                  <div className='check-box-container'>
                    <Form.Group controlId="formBasicCheckbox">
                      <Form.Check type="checkbox" label="Keep me logged in" />
                    </Form.Group>
                  </div>
                  <div className="row">
                    <div className="form-group col-md-10 mb-0">
                      <button type="submit" value="Submit" className='btn-submit'>
                        SignUp
                      </button>
                    </div>
                  </div>
                  <div className='row'>
                    <div className="col-md-10">
                      <div className='sign-up-text my-4 text-center'>
                        <p>Already have an account
                        <a href='/users/sign_in' className="ml-2 text-decoration-none">Sign In</a>
                        </p>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
              </Tab>
              </Tabs>
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

import React,{ useState }  from 'react';

import { Form, FormCheck, FormLabel } from 'react-bootstrap';
import { AiFillEyeInvisible } from "react-icons/ai";
import {Link} from 'react-router-dom';
import {InputField, Password, Error, CheckBoxContainer,BtnSubmit, SignUpText, ForgetPasswordText} from './style';

export default function CustomerReg() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  
  const submitForm = (e) => {
    e.preventDefault();
    if (email === "" || password === "") {
      setError("Fields are required");
      return;
    }
    props.login({ email, password });
  };
  
  const handleSubmit = (e)=> {
    e.preventDefault();
    console.log('form submitted')
  }
  return (
    
    <InputField>
    <form className='h-100' onSubmit = {handleSubmit}>
      <div className="row">
        <div className="form-group col-md-10">
          <input type="email" value={email} name="name" className='form-control' placeholder='Email address' onChange={e => setEmail(e.target.value)} />
          <Error>{error}</Error>
        </div>
      </div>
      <div className="row">
        <div className="form-group col-md-10">
          <Password>
            <input type="password" value={password} name="name" className='form-control' placeholder='Password' onChange={e => setPassword(e.target.value)} />
          </Password>
          <Error>{error}</Error>
        </div>
      </div>
      <div className="row">
        <div className="form-group col-md-10">
          <input type="text" value={email} name="name" className='form-control' placeholder='Organization Name' onChange={e => setEmail(e.target.value)} />
          <Error>{error}</Error>
        </div>
      </div>
      <div className="row">
        <div className="form-group col-md-10">
          <input type="text" value={email} name="name" className='form-control' placeholder='Organization Type' onChange={e => setEmail(e.target.value)} />
          <Error>{error}</Error>
        </div>
      </div>
      <CheckBoxContainer>
        <Form.Group controlId="formBasicCheckbox">
          <Form.Check type="checkbox" label="Keep me logged in" />
        </Form.Group>
      </CheckBoxContainer>
      <div className="row">
        <div className="form-group col-md-10 mb-0">
          <BtnSubmit type="submit" value="Submit" onClick={submitForm} />
        </div>
      </div>
      <div className='row'>
        <div className="col-md-10">
          <SignUpText className='my-4 text-center'>
            <p>Already have an account
              <Link className='ml-1' to='/users/sign_in'>Sign In</Link>
            </p>
          </SignUpText>
        </div>
      </div>
    </form>
  </InputField>
  )
}

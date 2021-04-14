import React,{ useState }  from 'react';
import styled from 'styled-components';
import { Form, FormCheck, FormLabel } from 'react-bootstrap';
import { AiFillEyeInvisible } from "react-icons/ai";
import {Link} from 'react-router-dom';
const InputField =  styled.div`
  input[type=email] {
    padding: 15px 10px;
    position: relative;
    height: auto;
    font-size: 12px;
    box-shadow: none;
  }
  input[type=password] {
    padding: 15px 10px;
    position: relative;
    height: auto;
    font-size: 12px;
    outline: none;
    box-shadow: none;
  }
`
const BtnSubmit = styled.input.attrs({ type: 'submit' })`
  width: 100%;
  background: #999;
  color: #fff;
  border: 0;
  outline: 0;
  padding: 10px;
`
const CheckBoxContainer = styled.div`
  padding: 20px 0;
  .form-check {
    padding-left: 0;
    input[type=checkbox] {
      margin: 0 10px 0 0;
      position: relative;
    }
    .form-check-label {
      color: #999;
      font-size: 14px;
    }
  }
`
const Password = styled.div`
  position: relative;
  svg {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
  }
`
const SignUpText = styled.div`
  p {
    font-size: 12px;
    a {
      color: #000;
      font-weight: bold;
      border-bottom: 1px solid #000;
    }
  }
`
const Error = styled.div`
  font-size: 12px;
  color: #C03131;
`

const ForgetPasswordText = styled.div`
  a {
    color: #000;
    font-weight: bold;
    border-bottom: 1px solid #000;
    font-size: 12px;
  }
`
export default function CustomerLogin() {
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
            <AiFillEyeInvisible/>
          </Password>
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
            <p>Dont have an account 
            
            <Link to='/users/sign_up'>Sign Up</Link>
            
            </p>
          </SignUpText>
          <ForgetPasswordText className='text-center'>
            <a href="">Forgotten password</a>
          </ForgetPasswordText>
        </div>
      </div>
      {console.log(error)}
      {/* {error && (
        <Alert severity="error" onClick={() => setError(null)}>
          {props.error || error}
        </Alert>
      )} */}
        </form>
    </InputField>
  )
}

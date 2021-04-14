
import React from "react"
import LoginPage from '../components/authentication/loginPage/loginPage';
import styled from 'styled-components/macro';
import {BrowserRouter as Router,Link , Route, Switch} from 'react-router-dom';
import SignUp from './signUp';
export default function login() {
  const LoginWrapper = styled.div`
    overflow-x: hidden;
    height: 100%;
  `
  return (
    <Router>
      {/* <LoginWrapper className='h-100'>
        <Switch>
          <Route path='/users/sign_in' render={LoginPage}/>
          <Route path='/users/sign_up' render={SignUp}/>
        </Switch>
      </LoginWrapper> */}
      <LoginWrapper className='h-100'>
        <LoginPage  className='h-100'></LoginPage>
      </LoginWrapper>
    </Router>
  )
}
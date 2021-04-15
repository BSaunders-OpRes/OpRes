
import React from "react"
import LoginPage from '../components/authentication/loginPage/loginPage';
import styled from 'styled-components/macro';
import {BrowserRouter as Router,Link , Route, Switch} from 'react-router-dom';
import RegPage from "../components/authentication/loginPage/registrationPage";
export default function login(props) {
  console.log(props)
  const LoginWrapper = styled.div`
    overflow-x: hidden;
    height: 100%;
  `
  return (
    <Router>
      <LoginWrapper className='h-100'>
        <Switch>
          <Route path='/users/sign_in' component={LoginPage}/>
          <Route path='/users/sign_up' component={RegPage}/>
        </Switch>
      </LoginWrapper>
    </Router>
  )
}
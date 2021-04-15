
import React from "react";
import CustomerLogin from '../customer_auth/customerLogin';
import { Tabs, Tab } from 'react-bootstrap';
import {FormWrapper, Styles} from './style';

export default function LoginForm() {
  return (
   <FormWrapper>
    <h1>Log into your account</h1>
    <Styles>
      <Tabs defaultActiveKey="customer" id="uncontrolled-tab-example">
       <Tab eventKey="customer" title="Customer Login">
      <CustomerLogin />
     </Tab>
    </Tabs>
   </Styles>
  </FormWrapper>
 );
}
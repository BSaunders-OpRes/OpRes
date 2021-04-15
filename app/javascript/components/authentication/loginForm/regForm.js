
import React from "react";
import CustomerReg from '../customerRegistration/customerReg';
import { Tabs, Tab } from 'react-bootstrap';
import {FormWrapper, Styles} from './style';

export default function RegForm() {
  return (
   <FormWrapper>
    <h1>Log into your account</h1>
    <Styles>
      <Tabs defaultActiveKey="customer" id="uncontrolled-tab-example">
       <Tab eventKey="customer" title="Customer Login">
      <CustomerReg />
     </Tab>
    </Tabs>
   </Styles>
  </FormWrapper>
 );
}
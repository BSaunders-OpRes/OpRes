import React, { useState }            from 'react';
import { Modal, Form, FormCheck, FormLabel, Button } from 'react-bootstrap';


const TermsCondition = (props) => {

  return (
    <Modal show={props.showModal} onClick={props.modalEvent} size="lg">
      <Modal.Header closeButton>
        <Modal.Title>Modal heading</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <div class="container terms-condition pl-2 pr-4">
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 pb-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Terms and Condition</h3>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                This OpRes Terms of Service ("<strong>Agreement</strong>") is enteredinto by and betweenOpRes Technology Consulting Limited ("<strong>OpRes</strong>") and the entity or personplacing an order for or accessing the Service ("<strong>Customer</strong>" or "<strong>you</strong>"). ThisAgreement consists of the terms and conditions setforth below. If you areaccessing or using the Service on behalf of your company,you represent thatyou are authorized to accept this Agreement on behalfof your company, and all references to "you" reference your company.The "Effective Date" of this Agreement is the datewhich is the earlier of (a)Customer's initial access to the Service through anyonline provisioning,registration or order process or (b) the effectivedate of the first Order. ThisAgreement will govern Customer's initial purchaseon the Effective Date aswell as any future purchases made by Customer thatreference thisAgreement. OpRes may modify this Agreement from timeto time as permittedin Section 19 (Modifications to Agreement).
              </p>
            </div>
          </div>
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 pb-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">overview</h3>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                OpRes offers a unique Service for operational resiliencereporting that isdesigned to allow Users to map, identify and analyseoperational resiliencegaps for their important business services. Customermaintains sole controlover the types and content of all Customer Contentit submits to the Service.
              </p>
            </div>
          </div>
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 pb-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">the services</h3>
              <h6 class="text-capitalize my-3 font-weight-bold">Permitted Use</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                During the Freemium Subscription Term, Customer may access and use the Service only for its internal business or personalpurposes in accordance withthis Agreement, including any usage limits in an Order.This includes the rightto copy and use the Software as part of Customer's authorized use of the Service.
              </p>
              <h6 class="text-capitalize my-3 font-weight-bold">Users</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Only Users may access or use the Service. Each Usermust keep its logincredentials confidential and not share them with anyoneelse. Customer isresponsible for its Users' compliance with this Agreement and actions takenthrough their accounts (excluding misuse of accountscaused by OpRes's breach of this Agreement). Customer will promptlynotify OpRes if it becomesaware of any compromise of its User login credentials.
              </p>
              <h6 class="text-capitalize my-3 font-weight-bold">Administrators</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Customer may designate a User as an administratorwith control overCustomer's Service account, including management ofUsers and Customer Content. Customer is fully responsible for its choiceof administrators and anyactions they take.
              </p>
              <h6 class="text-capitalize my-3 font-weight-bold">Customer Affiliates</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Customer's Affiliates may use the Service as Usersof Customer. Alternatively,an Affiliate of Customer may enter its own Order(s)as mutually agreed withOpRes, and this creates a separate agreement betweenthe Affiliate and OpRes that incorporates this Agreement with the Affiliatetreated as "Customer." Neither Customer nor any Customer Affiliatehas any rights under each other's agreement with OpRes, and breach or termination of any suchagreement is not breach nor termination under anyother.
              </p>
              <h6 class="text-capitalize my-3 font-weight-bold">Registration Using Corporate Email</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                If you created an account using an email address belongingto your employeror other entity, you represent and warrant that youhave authority to create anaccount on behalf of such entity and further acknowledgethat OpRes mayshare your email address with and control of youraccount may be taken overby such entity (as the "Customer"). Upon such takeover,the administrator controlling the account may be able to
                <ul class="list-unstyled pl-3 mb-0">
                  <li class="font-12 d-flex">
                    <strong class='font-12 mr-1'>(i)</strong>
                    <p className ='text-left line-height-30 font-14 font-xxl-14'>
                      Access,disclose, restrict or removeinformation from the account
                    </p>
                  </li>

                  <li class="font-12 d-flex">
                    <strong class='font-12 mr-1'>(ii)</strong>
                    <p className ='text-left line-height-30 font-14 font-xxl-14'>Restrict or terminateyour access to the Service and</p>
                  </li>
                  <li class="font-12 d-flex">
                    <strong class='font-12 mr-1'>(iii)</strong>
                    <p className ='text-left line-height-30 font-14 font-xxl-14'>Prevent you from later disassociatingsuch account from theCustomer.</p>
                  </li>
                </ul>
              </p>

              <h6 class="text-capitalize my-3 font-weight-bold">Sharing Settings</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Through the Service you control who you share OpResaccess with. OpReshas no liability for how others may access or use Customer Content as aresult of your or your Users' decision to provideaccess to the Service.
              </p>

              <h6 class="text-capitalize my-3 font-weight-bold">Age Requirement for Users</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                The Service is not intended for, and may not be usedby, anyone under theage of 16. Customer is responsible for ensuring thatall Users are at least 16 years old.
              </p>

              <h6 class="text-capitalize my-3 font-weight-bold">Restrictions</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Customer will not (and will not permit anyone else to) do any of the following:
                <ul class="list-unstyled pl-3 mb-0">
                  <li class="d-flex">
                    <span class="font-weight-bold">(a)</span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">Provide access to, distribute, sell or sublicensethe Service to a third party</p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (b)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Use the Service on behalf of, or to provide anyproduct or service to, thirdparties,
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (c)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Use the Service to develop a similaror competing product orservice,
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">(d)</span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Scrape, data mine, reverse engineer,decompile, disassemble orseek to access the source code or non-public APIsto or unauthorized datafrom the Service, except to the extent expressly permittedby Law (and thenonly with prior notice to OpRes).
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (e)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Modify or createderivative works of the Service or copy any element of the Service (otherthan authorized copies ofthe Software).
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">(f)</span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Remove or obscure any proprietarynotices in the Service orotherwise misrepresent the source of ownership ofthe Service.

                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (g)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Publish benchmarks or performance information about the Service.
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (h)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Interfere withthe Service's operation, circumvent its access restrictionsor conduct any security or vulnerability test of the Service.
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (i)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Transmit any viruses or other harmful materials to the Service.
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                      (j)
                    </span>
                    <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                      Allow Users to share User seats.
                    </p>
                  </li>
                  <li class="d-flex">
                    <span class="font-weight-bold">
                     (k)
                    </span>
                    <p className ='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                      Engage in any fraudulent, misleading, illegal or unethicalactivities related tothe Service or Use the Service to store or transmitmaterial which contains illegal content.
                    </p>
                  </li>
                </ul>
              </p>
            </div>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={props.modalEvent}>
          Close
        </Button>
        <Button variant="primary">
          Save Changes
        </Button>
      </Modal.Footer>
    </Modal>
  )
}

export default TermsCondition;
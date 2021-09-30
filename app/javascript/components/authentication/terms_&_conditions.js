import React, { useState }            from 'react';
import { Modal, Form, FormCheck, FormLabel, Button } from 'react-bootstrap';


const TermsCondition = (props) => {
  const onHide = () => {
  }
  return (
    <Modal show={props.showModal} onHide={props.modalEvent} size="lg">
      <Modal.Header closeButton className='border-0'>
        <h3 class="text-capitalize mt-3 font-weight-bold">Terms and Condition</h3>
      </Modal.Header>
      <Modal.Body className='pt-0' style = {{height: '450px', overflow: 'auto'}}>
        <div class="container terms-condition pl-2 pr-4">
          <div class="card border-0 mb-0 ">
            <div class="card-body rounded shadow-none px-0 py-0">
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                This OpRes Terms of Service ("<strong>Agreement</strong>") is enteredinto by and betweenOpRes Technology Consulting Limited ("<strong>OpRes</strong>") and the entity or personplacing an order for or accessing the Service ("<strong>Customer</strong>" or "<strong>you</strong>"). ThisAgreement consists of the terms and conditions setforth below. If you areaccessing or using the Service on behalf of your company,you represent thatyou are authorized to accept this Agreement on behalfof your company, and all references to "you" reference your company.The "Effective Date" of this Agreement is the datewhich is the earlier of (a)Customer's initial access to the Service through anyonline provisioning,registration or order process or (b) the effectivedate of the first Order. ThisAgreement will govern Customer's initial purchaseon the Effective Date aswell as any future purchases made by Customer thatreference thisAgreement. OpRes may modify this Agreement from timeto time as permittedin Section 19 (Modifications to Agreement).
              </p>
            </div>
          </div>
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize my-3 font-weight-bold">overview</h3>
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
                If you created an account using an email address belonging to your employeror other entity, you represent and warrant that youhave authority to create anaccount on behalf of such entity and further acknowledgethat OpRes mayshare your email address with and control of youraccount may be taken overby such entity (as the "Customer"). Upon such takeover,the administrator controlling the account may be able to
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
              </p>  
              <ul class="list-unstyled pl-3 mb-0">
                <li class="font-12 d-flex">
                  <span class="font-weight-bold font-12 mt-2">(a)</span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">Provide access to, distribute, sell or sublicensethe Service to a third party</p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Use the Service on behalf of, or to provide anyproduct or service to, thirdparties,
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Use the Service to develop a similaror competing product orservice,
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">(d)</span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                  Scrape, data mine, reverse engineer,decompile, disassemble orseek to access the source code or non-public APIsto or unauthorized datafrom the Service, except to the extent expressly permittedby Law (and thenonly with prior notice to OpRes).
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (e)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Modify or createderivative works of the Service or copy any element of the Service (otherthan authorized copies ofthe Software).
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">(f)</span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Remove or obscure any proprietarynotices in the Service orotherwise misrepresent the source of ownership ofthe Service.

                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (g)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Publish benchmarks or performance information about the Service.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (h)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Interfere withthe Service's operation, circumvent its access restrictionsor conduct any security or vulnerability test of the Service.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (i)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Transmit any viruses or other harmful materials to the Service.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                    (j)
                  </span>
                  <p class="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Allow Users to share User seats.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (k)
                  </span>
                  <p className ='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    Engage in any fraudulent, misleading, illegal or unethicalactivities related tothe Service or Use the Service to store or transmitmaterial which contains illegal content.
                  </p>
                </li>
              </ul>
            </div>
          </div>
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize my-3 font-weight-bold">support</h3>
              <p class="text-left line-height-30 font-14 font-xxl-14">During the Subscription Term, OpRes will provide abest endeavours supportservice. No service level agreements will be providedfor the solution as part of the Freemium Subscription Term.</p>
            </div>
          </div>
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize my-3 font-weight-bold">customer content</h3>
              <h6 class="text-capitalize mb-3 font-weight-bold">data use</h6>
              <p class="text-left line-height-30 font-14 mb-3 font-xxl-14">Customer grants OpRes the non-exclusive, worldwide right to use, copy,store, transmit and display Customer Content and tomodify and createderivative works of Customer Content (for reformattingor other technical purposes), but only as necessary to provide the Service,Support and anyTechnical Services to Customer under this Agreement.</p>
            </div>
          </div>
          <div class="card border-0 mb-0">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h6 class="text-capitalize mb-3 font-weight-bold">Security</h6>
              <p class="text-left line-height-30 font-14 mb-3 font-xxl-14">OpRes uses reasonable technical and organizational measures designed to protect the Service and Customer Content.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h6 class="text-capitalize mb-3 font-weight-bold">Data Export</h6>
              <p class="text-left line-height-30 font-14 font-xxl-14">During the Freemium Subscription Term or within 30days thereafter,Customer may delete its Customer Content from the Service. After this period,OpRes may delete Customer Content in accordance withits standard schedule and procedures. If Customer elects to proactivelydelete its accountat any time, all associated Customer Content willbe deleted permanently and cannot be retrieved.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Customer Obligations</h3>
              <h6 class="text-capitalize mb-3 font-weight-bold">Generally</h6>
              <p class="text-left line-height-30 font-14 font-xxl-14 mb-3">Customer is responsible for its Customer Content, including its content and accuracy, and agrees to comply with Laws in using the Service. Customer represents and warrants that it has made all disclosures and has all rights, consents and permissions necessary to use its Customer Content with the Service and grant OpRes the rights in <strong>Section 4.1 (Data Use), all withoutviolating or infringing Laws, third-party rights (includingintellectual property,publicity or privacy rights)</strong> or any terms or privacypolicies that apply to the Customer Content.</p>

              <h6 class="text-capitalize mb-3 font-weight-bold">Prohibited Uses</h6>
              <p class="text-left line-height-30 font-14 font-xxl-14">Customer must not use the Service with Prohibited Data or for High RiskActivities. Customer acknowledges that the Serviceis not intended to meetany legal obligations for these uses, including PCI and ISO requirements. Not with standing anything else in this Agreement, OpRes has no liability for Prohibited Data or use of the Service for High Risk Activities.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Suspension of Service</h3>
              <p class="text-left line-height-30 font-14 font-xxl-14">OpRes may suspend Customer's or a User's access to and use of the Service and related services if Customer breaches 
              <strong>Section 2.8 (Age Requirement forUsers)</strong>,
              <strong>Section 2.9 (Restrictions)</strong> or
              <strong>Section 5 (CustomerObligations)</strong> ,
              if Customer's account is 10 days or more overdue or if Customer's or User's actions risk harm to other customers or the security,availability or integrity ofthe Service. Where practicable, OpRes will use reasonable efforts to provide Customer with prior notice of the suspension. Once Customer resolves the issue requiring suspension, OpRes will restore Customer's or User's access to the Service in accordance with this Agreement.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Commercial Terms</h3>
              <h6 class="text-capitalize mb-3 font-weight-bold">Subscription Term</h6>
              <p class="text-left line-height-30 font-14 font-xxl-14">This subscription term is to utilise the OpRes Freemium product. The user has the ability to map 5 important business services. Any mapping of business services over this limit, will result in the drafting of new commercial terms between OpRes and the customer.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Warranties and Disclaimers</h3>
              <h6 class="text-capitalize mb-3 font-weight-bold">Limited Warranty</h6>

              <p class="pl-3">OpRes warrants to Customer that:</p>
              <ul class="pl-3">
                <li class="d-flex">
                  <span class="font-weight-bold">
                   (a)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    The Service will perform materially in a best endeavours model and OpRes will endeavour not to materially decrease the over all functionality of the Service during a Freemium Subscription Term.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold">
                   (b)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    OpRes will perform any Technical Services in a professional and work man like manner.
                  </p>
                </li>
              </ul>
              <h6 class="text-capitalize mb-3 font-weight-bold">Disclaimers</h6>
              <p class="mb-0 font-weight-bold text-left line-height-30 font-14 font-xxl-14">The Service, Support, Technical Services and all related OpRes services are provided "AS IS". OpRes and its suppliers make no other warranties, whether express, implied, statutory or otherwise, including warranties of merchant ability, fitness for a particular purpose, title or non infringement. Without limiting its express obligations in this agreement, OpRes does not warrant that Customer's use of the Service will be uninterrupted or error-free or that the Service will meet Customer's requirements, operate in combination with third-party services used by Customer or maintain
              Customer Content without loss. OpRes is not liable for delays, failures or problems inherent in use of the Internet and electronic communications or other systems outside OpRes's control. Customer may have other statutory rights, but any statutorily required warranties will be limited to the shortest legally permitted period.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Term and Termination</h3>
              <h6 class="text-capitalize mb-3 font-weight-bold">term</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                This Agreement starts on the Effective Date and continuesuntil the customernotifies OpRes that they wish to terminate their Freemium subscription.
              </p>
              <h6 class="text-capitalize my-3 font-weight-bold">Termination for Cause</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>Either party may terminate this Agreement if the other party:</p>
              <ul class="pl-3">
                <li class="d-flex">
                  <span class="font-weight-bold">
                   (a)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Fails to cure a material breach of this Agreement (including a failureto pay fees) within 30 days after notice,
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold">
                   (b)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Ceases operation without asuccessor.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold">
                   (c)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Seeks protection under a bankruptcy, receivership, trust deed, creditors arrangement, composition or comparable proceeding, or if such a proceeding is instituted against that party and not dismissed within 60 days.
                  </p>
                </li>
              </ul>

              <h6 class="text-capitalize my-3 font-weight-bold">Termination for Convenience</h6>
              <p>Either party may terminate this Agreement (includingall Orders) at any timefor any reason upon 90 days' notice to the other party, provided</p>
              <ul class="pl-3">
                <li class="d-flex">
                  <span class="font-weight-bold">
                   (i)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Customer will not be entitled to a refund of any pre-paid fees.
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold">
                    (ii)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    If Customer has not already paid all applicable fees for the then-current Subscription Term, anysuch fees that are outstanding will become immediately due and payable.
                  </p>
                </li>
              </ul>
              <h6 class="text-capitalize my-3 font-weight-bold">Effect of Termination</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>Upon expiration or termination of this Agreement or an Order, Customer's access to the Service and Technical Services will cease. At the disclosingparty's request upon expiration or termination of this Agreement, the receiving party will delete all of the disclosing party's Confidential Information (excluding Customer Content. Customer Content and other Confidential Information maybe retained in the receiving party's standard backups after deletion but will remain subject to this Agreement's confidentiality restrictions.</p>
              <h6 class="text-capitalize my-3 font-weight-bold">Survival</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>These Sections survive expiration or termination of this Agreement:Restrictions, Customer Obligations, Disclaimers, Effect of Termination, Survival, Ownership, Limitations of Liability, Indemnification, Confidentiality, Required Disclosures, General Terms and Definitions. Except where an exclusive remedy is provided, exercising a remedy under this Agreement, including termination, does not limit other remedies a party may have.</p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Ownership</h3>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                Neither party grants the other any rights or licenses not expressly set out in this Agreement. Except for OpRes's use rights in this Agreement, between the parties Customer retains all intellectual property and other rights in Customer Content and Customer Materials provided to OpRes. Except for Customer'suse rights in this Agreement, OpRes and its licensors retain all intellectual
                property and other rights in the Service, any Technical Services deliverables and related OpRes technology, templates, formats and dashboards, including any modifications or improvements to these items madeby OpRes. OpRes may generate and use Usage Data to operate, improve, analyze and support the Service and for other lawful business purposes. If Customer provides OpRes with feedback or suggestions regarding the Service or other OpRes offerings, OpRes may use the feedback or suggestions without restriction or obligation.
              </p>
            </div>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer>
        <Button className='black-btn w-150px font-600' variant="secondary" onClick={props.modalEvent}>
          Close
        </Button>
      </Modal.Footer>
    </Modal>
  )
}

export default TermsCondition;

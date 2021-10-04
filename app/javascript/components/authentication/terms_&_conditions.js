import React, { useState }            from 'react';
import { Modal, Form, FormCheck, FormLabel, Button } from 'react-bootstrap';


const TermsCondition = (props) => {
  return (
    <Modal show={props.showModal} onHide={props.modalEvent} size="lg">
      <Modal.Header closeButton className='border-0'>
        <h3 className="text-capitalize mt-3 font-weight-bold">Terms and Condition</h3>
      </Modal.Header>
      <Modal.Body className='pt-0' style = {{height: '450px', overflow: 'auto'}}>
        <div className="container terms-condition pl-2 pr-4">
          <div className="card border-0 mb-0 ">
            <div className="card-body rounded shadow-none px-0 py-0">
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                This OpRes Terms of Service ("<strong>Agreement</strong>") is enteredinto by and betweenOpRes Technology Consulting Limited ("<strong>OpRes</strong>") and the entity or personplacing an order for or accessing the Service ("<strong>Customer</strong>" or "<strong>you</strong>"). ThisAgreement consists of the terms and conditions setforth below. If you areaccessing or using the Service on behalf of your company,you represent thatyou are authorized to accept this Agreement on behalfof your company, and all references to "you" reference your company.The "Effective Date" of this Agreement is the datewhich is the earlier of (a)Customer's initial access to the Service through anyonline provisioning,registration or order process or (b) the effectivedate of the first Order. ThisAgreement will govern Customer's initial purchaseon the Effective Date aswell as any future purchases made by Customer thatreference thisAgreement. OpRes may modify this Agreement from timeto time as permittedin Section 19 (Modifications to Agreement).
              </p>
            </div>
          </div>
          <div className="card border-0 mb-0">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize my-3 font-weight-bold">overview</h3>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                OpRes offers a unique Service for operational resiliencereporting that isdesigned to allow Users to map, identify and analyseoperational resiliencegaps for their important business services. Customermaintains sole controlover the types and content of all Customer Contentit submits to the Service.
              </p>
            </div>
          </div>
          <div className="card border-0 mb-0">
            <div className="card-body rounded shadow-none px-0 pb-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">the services</h3>
              <h6 className="text-capitalize my-3 font-weight-bold">Permitted Use</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                During the Freemium Subscription Term, Customer may access and use the Service only for its internal business or personalpurposes in accordance withthis Agreement, including any usage limits in an Order.This includes the rightto copy and use the Software as part of Customer's authorized use of the Service.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Users</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Only Users may access or use the Service. Each Usermust keep its logincredentials confidential and not share them with anyoneelse. Customer isresponsible for its Users' compliance with this Agreement and actions takenthrough their accounts (excluding misuse of accountscaused by OpRes's breach of this Agreement). Customer will promptlynotify OpRes if it becomesaware of any compromise of its User login credentials.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Administrators</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Customer may designate a User as an administratorwith control overCustomer's Service account, including management ofUsers and Customer Content. Customer is fully responsible for its choiceof administrators and anyactions they take.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Customer Affiliates</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Customer's Affiliates may use the Service as Usersof Customer. Alternatively,an Affiliate of Customer may enter its own Order(s)as mutually agreed withOpRes, and this creates a separate agreement betweenthe Affiliate and OpRes that incorporates this Agreement with the Affiliatetreated as "Customer." Neither Customer nor any Customer Affiliatehas any rights under each other's agreement with OpRes, and breach or termination of any suchagreement is not breach nor termination under anyother.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Registration Using Corporate Email</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                If you created an account using an email address belonging to your employeror other entity, you represent and warrant that youhave authority to create anaccount on behalf of such entity and further acknowledgethat OpRes mayshare your email address with and control of youraccount may be taken overby such entity (as the "Customer"). Upon such takeover,the administrator controlling the account may be able to
                <ul className="list-unstyled pl-3 mb-0">
                  <li className="font-12 d-flex">
                    <strong className='font-12 mr-1'>(i)</strong>
                    <p className ='text-left line-height-30 font-14 font-xxl-14'>
                      Access,disclose, restrict or removeinformation from the account
                    </p>
                  </li>

                  <li className="font-12 d-flex">
                    <strong className='font-12 mr-1'>(ii)</strong>
                    <p className ='text-left line-height-30 font-14 font-xxl-14'>Restrict or terminateyour access to the Service and</p>
                  </li>
                  <li className="font-12 d-flex">
                    <strong className='font-12 mr-1'>(iii)</strong>
                    <p className ='text-left line-height-30 font-14 font-xxl-14'>Prevent you from later disassociatingsuch account from theCustomer.</p>
                  </li>
                </ul>
              </p>

              <h6 className="text-capitalize my-3 font-weight-bold">Sharing Settings</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Through the Service you control who you share OpResaccess with. OpReshas no liability for how others may access or use Customer Content as aresult of your or your Users' decision to provideaccess to the Service.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Age Requirement for Users</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                The Service is not intended for, and may not be usedby, anyone under theage of 16. Customer is responsible for ensuring thatall Users are at least 16 years old.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Restrictions</h6>
              <p className ='text-left line-height-30 font-14 font-xxl-14'>
                Customer will not (and will not permit anyone else to) do any of the following:
              </p>  
              <ul className="list-unstyled pl-3 mb-0">
                <li className="font-12 d-flex">
                  <span className="font-weight-bold font-12 mt-2">(a)</span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">Provide access to, distribute, sell or sublicensethe Service to a third party</p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Use the Service on behalf of, or to provide anyproduct or service to, thirdparties,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Use the Service to develop a similaror competing product orservice,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">(d)</span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                  Scrape, data mine, reverse engineer,decompile, disassemble orseek to access the source code or non-public APIsto or unauthorized datafrom the Service, except to the extent expressly permittedby Law (and thenonly with prior notice to OpRes).
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (e)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Modify or createderivative works of the Service or copy any element of the Service (otherthan authorized copies ofthe Software).
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">(f)</span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Remove or obscure any proprietarynotices in the Service orotherwise misrepresent the source of ownership ofthe Service.

                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (g)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Publish benchmarks or performance information about the Service.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (h)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Interfere withthe Service's operation, circumvent its access restrictionsor conduct any security or vulnerability test of the Service.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (i)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Transmit any viruses or other harmful materials to the Service.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (j)
                  </span>
                  <p className="text-left line-height-30 font-14 font-xxl-14 ml-1">
                    Allow Users to share User seats.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (k)
                  </span>
                  <p className ='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    Engage in any fraudulent, misleading, illegal or unethicalactivities related tothe Service or Use the Service to store or transmitmaterial which contains illegal content.
                  </p>
                </li>
              </ul>
            </div>
          </div>
          <div className="card border-0 mb-0">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize my-3 font-weight-bold">support</h3>
              <p className="text-left line-height-30 font-14 font-xxl-14">During the Subscription Term, OpRes will provide abest endeavours supportservice. No service level agreements will be providedfor the solution as part of the Freemium Subscription Term.</p>
            </div>
          </div>
          <div className="card border-0 mb-0">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize my-3 font-weight-bold">customer content</h3>
              <h6 className="text-capitalize mb-3 font-weight-bold">data use</h6>
              <p className="text-left line-height-30 font-14 mb-3 font-xxl-14">Customer grants OpRes the non-exclusive, worldwide right to use, copy,store, transmit and display Customer Content and tomodify and createderivative works of Customer Content (for reformattingor other technical purposes), but only as necessary to provide the Service,Support and anyTechnical Services to Customer under this Agreement.</p>
            </div>
          </div>
          <div className="card border-0 mb-0">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h6 className="text-capitalize mb-3 font-weight-bold">Security</h6>
              <p className="text-left line-height-30 font-14 mb-3 font-xxl-14">OpRes uses reasonable technical and organizational measures designed to protect the Service and Customer Content.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h6 className="text-capitalize mb-3 font-weight-bold">Data Export</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">During the Freemium Subscription Term or within 30days thereafter,Customer may delete its Customer Content from the Service. After this period,OpRes may delete Customer Content in accordance withits standard schedule and procedures. If Customer elects to proactivelydelete its accountat any time, all associated Customer Content willbe deleted permanently and cannot be retrieved.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Customer Obligations</h3>
              <h6 className="text-capitalize mb-3 font-weight-bold">Generally</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14 mb-3">Customer is responsible for its Customer Content, including its content and accuracy, and agrees to comply with Laws in using the Service. Customer represents and warrants that it has made all disclosures and has all rights, consents and permissions necessary to use its Customer Content with the Service and grant OpRes the rights in <strong className='font-12'>Section 4.1 (Data Use), all withoutviolating or infringing Laws, third-party rights (includingintellectual property,publicity or privacy rights)</strong> or any terms or privacypolicies that apply to the Customer Content.</p>

              <h6 className="text-capitalize mb-3 font-weight-bold">Prohibited Uses</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">Customer must not use the Service with Prohibited Data or for High RiskActivities. Customer acknowledges that the Serviceis not intended to meetany legal obligations for these uses, including PCI and ISO requirements. Not with standing anything else in this Agreement, OpRes has no liability for Prohibited Data or use of the Service for High Risk Activities.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Suspension of Service</h3>
              <p className="text-left line-height-30 font-14 font-xxl-14">OpRes may suspend Customer's or a User's access to and use of the Service and related services if Customer breaches 
              <strong className='ml-1 font-14'>Section 2.8 (Age Requirement forUsers)</strong>,
              <strong className='ml-1 font-14'>Section 2.9 (Restrictions)</strong> or
              <strong className='ml-1 font-14'>Section 5 (CustomerObligations)</strong> ,
              if Customer's account is 10 days or more overdue or if Customer's or User's actions risk harm to other customers or the security,availability or integrity ofthe Service. Where practicable, OpRes will use reasonable efforts to provide Customer with prior notice of the suspension. Once Customer resolves the issue requiring suspension, OpRes will restore Customer's or User's access to the Service in accordance with this Agreement.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Commercial Terms</h3>
              <h6 className="text-capitalize mb-3 font-weight-bold">Subscription Term</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">This subscription term is to utilise the OpRes Freemium product. The user has the ability to map 5 important business services. Any mapping of business services over this limit, will result in the drafting of new commercial terms between OpRes and the customer.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Warranties and Disclaimers</h3>
              <h6 className="text-capitalize mb-3 font-weight-bold">Limited Warranty</h6>

              <p className="pl-3 font-600 font-12">OpRes warrants to Customer that:</p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    The Service will perform materially in a best endeavours model and OpRes will endeavour not to materially decrease the over all functionality of the Service during a Freemium Subscription Term.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    OpRes will perform any Technical Services in a professional and work man like manner.
                  </p>
                </li>
              </ul>
              <h6 className="text-capitalize mb-3 font-weight-bold">Disclaimers</h6>
              <p className="mb-0 font-weight-bold text-left line-height-30 font-14 font-xxl-14">The Service, Support, Technical Services and all related OpRes services are provided "AS IS". OpRes and its suppliers make no other warranties, whether express, implied, statutory or otherwise, including warranties of merchant ability, fitness for a particular purpose, title or non infringement. Without limiting its express obligations in this agreement, OpRes does not warrant that Customer's use of the Service will be uninterrupted or error-free or that the Service will meet Customer's requirements, operate in combination with third-party services used by Customer or maintain
              Customer Content without loss. OpRes is not liable for delays, failures or problems inherent in use of the Internet and electronic communications or other systems outside OpRes's control. Customer may have other statutory rights, but any statutorily required warranties will be limited to the shortest legally permitted period.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Term and Termination</h3>
              <h6 className="text-capitalize mb-3 font-weight-bold">term</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                This Agreement starts on the Effective Date and continuesuntil the customernotifies OpRes that they wish to terminate their Freemium subscription.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Termination for Cause</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>Either party may terminate this Agreement if the other party:</p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Fails to cure a material breach of this Agreement (including a failureto pay fees) within 30 days after notice,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Ceases operation without asuccessor.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Seeks protection under a bankruptcy, receivership, trust deed, creditors arrangement, composition or comparable proceeding, or if such a proceeding is instituted against that party and not dismissed within 60 days.
                  </p>
                </li>
              </ul>
              <h6 className="text-capitalize my-3 font-weight-bold">Termination for Convenience</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">Either party may terminate this Agreement (includingall Orders) at any timefor any reason upon 90 days' notice to the other party, provided</p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (i)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Customer will not be entitled to a refund of any pre-paid fees.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (ii)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    If Customer has not already paid all applicable fees for the then-current Subscription Term, anysuch fees that are outstanding will become immediately due and payable.
                  </p>
                </li>
              </ul>
              <h6 className="text-capitalize my-3 font-weight-bold">Effect of Termination</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>Upon expiration or termination of this Agreement or an Order, Customer's access to the Service and Technical Services will cease. At the disclosingparty's request upon expiration or termination of this Agreement, the receiving party will delete all of the disclosing party's Confidential Information (excluding Customer Content. Customer Content and other Confidential Information maybe retained in the receiving party's standard backups after deletion but will remain subject to this Agreement's confidentiality restrictions.</p>
              <h6 className="text-capitalize my-3 font-weight-bold">Survival</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>These Sections survive expiration or termination of this Agreement:Restrictions, Customer Obligations, Disclaimers, Effect of Termination, Survival, Ownership, Limitations of Liability, Indemnification, Confidentiality, Required Disclosures, General Terms and Definitions. Except where an exclusive remedy is provided, exercising a remedy under this Agreement, including termination, does not limit other remedies a party may have.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Ownership</h3>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                Neither party grants the other any rights or licenses not expressly set out in this Agreement. Except for OpRes's use rights in this Agreement, between the parties Customer retains all intellectual property and other rights in Customer Content and Customer Materials provided to OpRes. Except for Customer'suse rights in this Agreement, OpRes and its licensors retain all intellectual
                property and other rights in the Service, any Technical Services deliverables and related OpRes technology, templates, formats and dashboards, including any modifications or improvements to these items madeby OpRes. OpRes may generate and use Usage Data to operate, improve, analyze and support the Service and for other lawful business purposes. If Customer provides OpRes with feedback or suggestions regarding the Service or other OpRes offerings, OpRes may use the feedback or suggestions without restriction or obligation.
              </p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-0 font-weight-bold">Limitations of Liability</h3>
              <h6 className="text-capitalize my-3 font-weight-bold">Consequential Damages Waiver</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                This Consequential Damages Waiver will not apply tothe extent prohibited by Laws. Except for Excluded Claims, neitherparty (nor its suppliers) will have any liability arising out ofor related to this Agreement for any loss of use, lost data, lost profits, failure of security mechanisms, revenues, goodwill, interruption of business or any indirect, special, incidental, reliance or consequential damages of any kind, even if informed of their possibility in advance.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Liability Cap</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                Except for Excluded Claims, each party's (and itssuppliers') entire liability arising out of or related to this Agreement will not exceed in aggregate the amounts paid or payable by Customer to OpRes duringthe prior 3-months under this Agreement.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Excluded Claims</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>
                <strong className='font-14'>"Excluded Claims"</strong> means:
              </p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    Customer's breach of Restrictions orCustomer Obligations.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (b)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    Either party's breach of Confidentiality but excluding claims relating to Customer Content).
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (c)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    Amounts payable to third parties under Customer' obligations in  respect of Indemnification by Customer
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (d)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    Either party's willful misconduct or
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (e)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    OpRes's performance of the Service that results in death, personal injury or damage to tangible property
                  </p>
                </li>
              </ul>
              <h6 className="text-capitalize my-3 font-weight-bold">Nature of Claims and Failure of Essential Purpose</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                The waivers and limitations in this agreement apply regardless of the form of action, whether in contract, tort (including negligence), strict liability or otherwise and will survive and apply even if any limited remedy in this Agreement fails of its essential purpose.
              </p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-0 font-weight-bold">Indemnification</h3>
              <h6 className="text-capitalize my-3 font-weight-bold">Indemnification by OpRes</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>OpRes will defend Customer from and against any third-partyclaim to the extent alleging that the Service, when used by Customer as authorized in this Agreement, infringes a third party's patent, copyright, trademark or tradesecret, and will indemnify and hold harmless Customer against any damages or costs awarded against Customer (including reasonable attorneys' fees) or agreed in settlement by OpRes resulting from the claim.</p>

              <h6 className="text-capitalize my-3 font-weight-bold">Indemnification by Customer</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>Customer will defend OpRes from and against any third-party claim to the extent resulting from Customer Content, Customer Materials or Customer's breach or alleged breach of the Customer Obligations, and will indemnify and hold harmless OpRes against any damages or costs awarded against OpRes(including reasonable attorneys' fees) or agreed in settlement by Customer resulting from the claim.</p>

              <h6 className="text-capitalize my-3 font-weight-bold">Procedures</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>The indemnifying party's obligations in this agreement are subject to receiving</p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Prompt notice of the claim.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (b)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    The exclusive right to control and direct the investigation, defense and settlement ofthe claim.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                    (d)
                  </span>
                  <p className='text-left line-height-30 font-14 font-xxl-14 ml-1'>
                    All reasonably necessary cooperation of the indemnified party, at the indemnifying party's expense for reasonable out-of-pocket costs.
                  </p>
                </li>
              </ul>
              <p className='text-left line-height-30 font-14 font-xxl-14'>The indemnifying party may not settle any claim with out the indemnified party's prior consent if settlement would require the indemnified party to admit fault or take or refrain from taking any action (other thanrelating to use of the Service,when OpRes is the indemnifying party). The indemnified party may participate in a claim with its own counsel at its own expense.</p>

              <h6 className="text-capitalize my-3 font-weight-bold">Mitigation and Exceptions</h6>
              <p className='text-left line-height-30 font-14 font-xxl-14'>In response to an actual or potential infringementclaim, if required bysettlement or injunction or as OpRes determines necessaryto avoid materialliability, OpRes may at its option:</p>
              <ul>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Procure rights for Customer's continued use of the Service,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Replace or modify the alleged lyin fringing portion of the Service to avoid infringement without reducing the Service's overall functionality or
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Terminate the affected Order and refund to Customer any pre-paid, unused fees for the terminated portion ofthe Subscription Term. OpRes's obligations in this agreement do not apply.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (1)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    To the extent infringement results from Customer's modification of the Service or use of the Service in combination with items not provided by OpRes (including Third-Party Platforms).
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (2)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    To infringement resulting from Software other than the most recent release provided by OpRes,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (3)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    To unauthorized use of the Service,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (4)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    If Customer settles or makes any admissions about a claim without OpRes's prior consent,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (5)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    If Customer continues to use the Service(or any element thereof) after being notified of alleged lyin fringing activity or informed of modifications that would have avoided the alleged infringement or
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (6)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    To Trials and Betas or other free or evaluation use.
                  </p>
                </li>
              </ul>
              <p className="font-weight-bold font-12"> This section sets out Customer's exclusive remedy and OpRes's entire liability regarding in fringement of third-party intellectual property rights.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-0 font-weight-bold">Confidentiality</h3>
              <h6 className="text-capitalize my-3 font-weight-bold">Definition</h6>
              
              <p className="text-left line-height-30 font-14 font-xxl-14"><strong className="text-left line-height-30 font-14 font-xxl-14">"Confidential Information"</strong> means information disclosed to the receiving party under this Agreement that is designated by the disclosing party as proprietary or confidential or that should be reasonably understood to be proprietary or confidential due to its nature and the circumstances of its disclosure. OpRes's Confidential Information includes the terms and conditions of this Agreement and any technical or performance information about the Service. Customer's Confidential Information includes Customer Content.</p>

              <h6 className="text-capitalize my-3 font-weight-bold">Obligations</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">As receiving party, each party will:</p>
                <ul className="pl-3">
                  <li className="d-flex">
                    <span className="font-weight-bold font-12 mt-2">
                      (a)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      Hold Confidential Information in confidence and not disclose it to third parties exceptas permitted in this Agreement, including <strong className='font-14'>Section 4.1 (Data Use)</strong>.
                    </p>
                  </li>
                  <li className="d-flex">
                    <span className="font-weight-bold font-12 mt-2">
                      (b)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      only use ConfidentialInformation to fulfill its obligations and exercise its rights in this Agreement. The receiving party may disclose Confidential Information to its employees, agents, contractors and other representatives having a legitimate need to know (including, for OpRes, the subcontractors referenced in Section 20.9), provided it remains responsible for their compliance with this Section 15 and they are bound to confidentiality obligations no less protective than this Section 15.
                    </p>
                  </li>
                </ul>
              <h6 className="text-capitalize mb-3 font-weight-bold">Exclusions</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">These confidentiality obligations do not apply toinformation that the receiving party can document.</p>
                <ul className="pl-3">
                  <li className="d-flex">
                    <span className="font-weight-bold font-12 mt-2">
                      (a)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      Is or becomes public knowledge through no fault of the receiving party.
                    </p>
                  </li>
                  <li className="d-flex">
                    <span className="font-weight-bold font-12 mt-2">
                      (b)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      It rightfully knew or possessed prior to receipt under this Agreement.
                    </p>
                  </li>
                  <li className="d-flex">
                    <span className="font-weight-bold font-12 mt-2">
                      (c)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      It rightfully received from athird party without breach of confidentiality obligations
                    </p>
                  </li>
                  <li className="d-flex">
                    <span className="font-weight-bold font-12 mt-2">
                      (d)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      it independentlydeveloped without using thedisclosing party's Confidential Information.
                    </p>
                  </li>
                </ul>
              <h6 className="text-capitalize my-3 font-weight-bold">Remedies</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">Unauthorized use or disclosure of Confidential Information may cause substantial harm for which damages alone are an insufficient remedy. Each party may seek appropriate equitable relief, in addition to other available remedies, for breach or threatened breach of this agreement.</p>
              <h6 className="text-capitalize my-3 font-weight-bold">Required Disclosures</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">Nothing in this Agreement prohibits either party from making disclosures, including of Customer Content and other Confidential Information, if required by Law, subpoena or court order, provided (if permitted by Law) it notifies the
              other party in advance and cooperates in any effort to obtain confidential treatment.</p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Freemium Consumption Model</h3>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                If Customer receives access to the Service or Service features on a free or trial basis or as an alpha, beta or early access offering ("<strong>Trials and Betas</strong>"), use is permitted only for Customer's internal evaluation during the period designated by OpRes.
                Trials and Betas are optional and either party may terminate Trials and Betas at any time for any reason. Trials and Betas maybe in operable, incomplete or include features that OpRes may never release, and their features and performance information are OpRes's Confidential Information. 
                <strong className='ml-1'>Notwithstanding anything else in this Agreement, OpRes provides a Freemium Consumption Services, Trials and Betas "AS IS" with no warranty, indemnity or support and its liability for Freemium Consumption Services, Trials and Betas will not exceed GBP £50.</strong>
              </p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Publicity</h3>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Neither party may publicly announce this Agreement except with the other party's prior consent or as required by Laws. However, OpRes may includeCustomer and its trademarks in OpRes's customer lists and promotional materials but will cease this use at Customer's written request.
              </p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-3 font-weight-bold">Modifications to Agreement</h3>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                OpRes may modify this Agreement (which may include changes to Service pricing and plans) from time to time by giving notice to Customer by email or through the Service. Unless a shorter period is specified by OpRes (e.g., due to changes in the Law or exigent circumstances), modifications become effective upon renewal of Customer's current Subscription Term or entry into a new Order. If OpRes specifies that the modifications to the Agreement will take effect prior to Customer's next renewal or Order and Customer notifies OpRes of its objection to the modifications within 30 days after the date of such notice, OpRes (at its option and as Customer's exclusive remedy) will either:
                <ul className="pl-3">
                  <li className="d-flex">
                    <span className="font-weight-bold font-12">
                     (a)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      Permit Customer to continue under the existing version of this Agreement until expiration of the then-current Subscription Term (after which time the modified Agreement will go into effect) or
                    </p>
                  </li>
                  <li className="d-flex">
                    <span className="font-weight-bold font-12">
                     (b)
                    </span>
                    <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                      Allow Customer to terminate this Agreement and receive a refund of any pre-paid Service fees allocable to the terminated portion of the applicable Subscription Term. Customer may be required to click to accept or otherwise agree to the modified Agreement in order to continue using the Service, and, in any event, continued use of the Service after the updated version of this Agreement goes into effect will constitute Customer's acceptance of such updated version.
                    </p>
                  </li>
                </ul>
              </p>
            </div>
          </div>
          <div className="card border-0 mb-4">
            <div className="card-body card-body rounded shadow-none px-0 py-0">
              <h3 className="text-capitalize mb-0 font-weight-bold">General Terms</h3>
              <h6 className="text-capitalize my-3 font-weight-bold">Assignment</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Neither party may assign this Agreement without the prior consent of the other party, except that either party may assign this Agreement in connection with a merger, reorganization, acquisition or other transfer of all or substantially all its assets or voting securities. Any non-permitted assignmentis void. This Agreement will bind and inure to the benefit of eachparty's permitted successors and assigns.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Governing Law, Jurisdiction and Venue</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                This Agreement is governed by the laws of the UnitedKingdom without regard to conflicts of laws provisions and without regard to the United Nations Convention on the International Sale of Goods. The jurisdiction and venue for actions related to this Agreement will be the courts located in the United Kingdom, and both parties submit to the personal jurisdiction of those courts.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Attorneys' Fees and Costs</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                The prevailing party in any action to enforce this Agreement will be entitled to recover its reasonable attorneys' fees and costs in connection with such action.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Notices</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Except as set out in this Agreement, any notice orconsent under this Agreement must be in writing and will be deemed given:
              </p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Upon receipt if bypersonal delivery,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Upon receipt if by certifiedor registered U.K. mail (returnreceipt requested) or
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    One day after dispatch if by a commercial overnight delivery service. If to OpRes, notice must be provided to OpRes Technology Consulting Limited. 5 Farriers Mews, Nunhead, London, United Kingdom, SE153XP, Attention: Legal Department. All notices to OpRes must include a copy emailed to HQ@opres.com. If to Customer, OpRes may provide notice to the address Customer provided at registration.Either party may update its address with notice to the other party. OpRes may also send operational notices to Customer by email or through the Service.
                  </p>
                </li>
              </ul>

              <h6 className="text-capitalize my-3 font-weight-bold">Entire Agreement</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                This Agreement (which includes all Orders and the Policies)  is the parties' entire agreement regarding its subject matter and supersedes any prior or contemporaneous agreements regarding its subject matter.In this Agreement, headings are for convenience only and "including" and similar terms are to be construed without limitation. This Agreement may be executed in counter parts (including electronic copies and PDFs), each of which is deemed an original and which together form one and the same agreement.
              </p>

              <h6 className="text-capitalize my-3 font-weight-bold">Amendments</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Except as otherwise provided here in, any amendments, modifications or supplements to this Agreement must be in writing and signed by each party's authorized representatives or, as appropriate, agreed through electronic means provided by OpRes. Nonetheless, with notice to Customer, OpRes may modify the Policies to reflect new features or changing practices, but the modifications will not materially decrease OpRes's overall obligations during a Subscription Term. The terms in any past, contemporaneousor future Customer purchase order, business form or vendor management portal will not amend or modify this Agreement and are expressly rejected by OpRes; any of these documents are for administrative purposesonly and have no legal effect.
              </p>

              <h6 className="text-capitalize my-3 font-weight-bold">Waivers and Severability</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Waivers must be signed by the waiving party's authorized representative and cannot be implied from conduct. If any provision of this Agreement is held invalid, illegal or un enforceable, it will be limited to the minimum extent necessary so the rest of this Agreement remains ineffect.
              </p>

              <h6 className="text-capitalize my-3 font-weight-bold">Force Majeure</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Neither party is liable for any delay or failure to perform any obligation under this Agreement (except for a failure to pay fees) due to events beyond its reasonable control, such as a strike, blockade, war, act of terrorism, riot, Internet or utility failures, refusal of government license or natural disaster.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Subcontractors</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                OpRes may use subcontractors and permit them to exerciseOpRes's rights, but OpRes remains responsible for their compliance with this Agreement and for its overall performance under this Agreement.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Independent Contractors</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                The parties are independent contractors, not agents, partners or joint venturers.
              </p>
              <h6 className="text-capitalize my-3 font-weight-bold">Export</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                Customer agrees to comply with all relevant U.K. and foreign export and import Laws in using the Service.
              </p>
              <ul className="pl-3">
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Represents and warrants that itis not listed on any U.K. government list of prohibitedor restricted parties orlocated in (or a national of) a country that is subjectto a U.K. governmentembargo or that has been designated by the U.K. governmentas a "terrorist supporting" country,
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Agrees not to access or usethe Service in violation ofany U.K. export embargo, prohibition or restriction.
                  </p>
                </li>
                <li className="d-flex">
                  <span className="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p className="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Will not submit tothe Service any information controlled under the U.K.International Traffic inArms Regulations.
                  </p>
                </li>
              </ul>
              <h6 className="text-capitalize mb-3 font-weight-bold">Open Source</h6>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                The Software may incorporate third-party open source software ("OSS"). Tothe extent required by the OSS license, that licensewill apply to the OSS on astand-alone basis instead of this Agreement.
              </p>
            </div>
          </div>
          <div class="card border-0 mb-4">
            <div class="card-body card-body rounded shadow-none px-0 py-0">
              <h3 class="text-capitalize mb-3 font-weight-bold">Definitions</h3>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Affiliate"</strong>
                means an entity that, directly or indirectly, owns or controls, is owned or controlled by, or is under common ownership or control with a party, where "ownership" means the beneficial ownership offifty percent (50%) ormore of an entity's voting equity securities or otherequivalent voting interests and "control" means the power to direct the management or affairs of an entity.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Customer Content"</strong>
                means any data, content or materialsthat Customer (including its Users) creates within or submits to the Service, including from Third-Party Platforms.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Customer Materials"</strong>
                means materials, systems and other resources that Customer provides to OpRes in connection with Technical Services.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"High Risk Activities"</strong>
                means activities where use or failure of the Service could lead to death, personal injury or environmental damage, including life support systems, emergency services, financial systems, nuclear facilities, autonomous vehicles or air traffic control.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Laws"</strong>
                means all relevant local, state, federal and international laws, regulations and conventions, including those related to data privacy and data transfer, international communications and export of technical or personal data.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Order"</strong>
                means any OpRes-provided ordering document, online registration, order description or order confirmation referencing this Agreement.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Policies"</strong>
                means the Privacy Policy, Security Policy and Support Policy.
              </p>
              <p className="text-left line-height-30 font-14 font-xxl-14">
                <strong className='font-14 mr-1 font-14'>"Prohibited Data"</strong>
                means any
              </p>
              <ul class="pl-3">
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (a)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Special categories of data enumerated in European Union Regulation 2016/679, Article 9(1) or any successor legislation,
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (b)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Patient, medical or other protected health information regulated by the Health Insurance Portability and Accountability Act (as amended and supplemented) ("HIPAA"),
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (c)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Credit, debit or otherpayment card data subject to the Payment Card Industry Data Security Standards (PCI DSS)
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (d)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Other information subject to regulation or protection under specific Laws such as the Children's Online Privacy Protection Act or Gramm-Leach-Bliley Act (orrelated rules or regulations),
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (e)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Social security numbers, driver's license numbers or other government ID numbers or
                  </p>
                </li>
                <li class="d-flex">
                  <span class="font-weight-bold font-12 mt-2">
                   (f)
                  </span>
                  <p class="ml-1 text-left line-height-30 font-14 font-xxl-14">
                    Anydata similar to the aboveprotected under foreign or domestic Laws
                  </p>
                </li>
              </ul>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Security Policy"</strong>
                means the OpRes Security Policy
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Service"</strong>
                means OpRes's proprietary cloud service, as identified in the relevant Order and as modified from time to time. The Service includes the Software and Documentation but does not include Technical Services deliverables or Third-Party Platforms.
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Software"</strong>
                means any OpRes client software, scripts, apps or other code provided to Customer by OpRes for use with the Service.
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Subscription Term"</strong>
                means the term for Customer's use of the Service as identified in an Order.
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Support"</strong>
                means best endeavours support for the Service as part of the Freemium consumption model.
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Technical Services"</strong>
                means any training, enablement or other technical services provided by OpRes related to the Service, as identified in an Order
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Usage Data"</strong>
                means OpRes's technical logs, data and learnings about Customer's use of the Service, but excluding Customer Content.
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"Third-Party Platform"</strong>
                means any platform, add-on, service, product, app or integration not provided by OpRes that Customer elects to integrate or enable for use with the Service.
              </p>
              <p class="text-left line-height-30 font-14 font-xxl-14">
                <strong class="font-12 mr-1">"User"</strong>
                means any individual that Customer or its Affiliate permits or invites to use the Service
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

import React from 'react';
import Carousel from '../carousel/carousel';
import RegForm from '../loginForm/regForm';
import Logo from '../../../images/logo.png';
import styled from 'styled-components/macro';

export default function RegPage() {

  const LogoContainer = styled.div`
    height: 150px;
    display: flex;
    align-items: center;
    padding-left: 100px;
    img {
      width: 100px;
    }
    @media (max-width: 768px) {
      padding: 0 15px;
      justify-content: center;
    }
  `
  return (
    <>
      <div className='row h-100'>
        <div className="col-md-6">
          <LogoContainer>
            <img src={Logo} alt=""/>
          </LogoContainer>
          <RegForm/>
        </div>
        <div className="col-md-6">
          <Carousel/>
        </div>
      </div>
    </>
  )
}

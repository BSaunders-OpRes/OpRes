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
  `
  return (
    <>
      <div className='row h-100'>
        <div className="col-sm-6">
          <LogoContainer>
            <img src={Logo} alt=""/>
          </LogoContainer>
          <RegForm/>
        </div>
        <div className="col-sm-6">
          <Carousel/>
        </div>
      </div>
    </>
  )
}

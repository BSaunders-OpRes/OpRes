import styled from 'styled-components/macro';

export const FormWrapper =  styled.div`
  background-color: #fff;
  display: flex;
  justify-content: flex-start;
  flex-direction: column;
  padding-left: 100px;
`

export const Styles =  styled.div`
  .nav-tabs {
    border: 0;
    padding: 10px 0;
    visibility: hidden;
  .nav-link.active {
    position: relative;
    color: #000;
    &:after {
      content: '';
      position: absolute;
      left: 0;
      width: 40px;
      height: 2px;
      background-color: #6BEAB3;
      top: 100%;
    }
  }
  .nav-link {
    border: 0;
    background: transparent;
    padding: 0;
    font-size: 12px;
    color: #333;
    padding-bottom: 5px;
    &:first-child {
      margin-right: 20px;
    }
  }
 }
`
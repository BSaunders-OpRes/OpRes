import styled from 'styled-components';

export const InputField =  styled.div`
  input[type=email] {
    padding: 15px 10px;
    position: relative;
    height: auto;
    font-size: 12px;
    box-shadow: none;
  }
  input[type=password] {
    padding: 15px 10px;
    position: relative;
    height: auto;
    font-size: 12px;
    outline: none;
    box-shadow: none;
  }
`
export const BtnSubmit = styled.input.attrs({ type: 'submit' })`
  width: 100%;
  background: #999;
  color: #fff;
  border: 0;
  outline: 0;
  padding: 10px;
`
export const CheckBoxContainer = styled.div`
  padding: 20px 0;
  .form-check {
    padding-left: 0;
    input[type=checkbox] {
      margin: 0 10px 0 0;
      position: relative;
    }
    .form-check-label {
      color: #999;
      font-size: 14px;
    }
  }
`
export const Password = styled.div`
  position: relative;
  svg {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
  }
`
export const SignUpText = styled.div`
  p {
    font-size: 12px;
    a {
      color: #000;
      font-weight: bold;
      border-bottom: 1px solid #000;
    }
  }
`
export const Error = styled.div`
  font-size: 12px;
  color: #C03131;
`

export const ForgetPasswordText = styled.div`
  a {
    color: #000;
    font-weight: bold;
    border-bottom: 1px solid #000;
    font-size: 12px;
  }
`
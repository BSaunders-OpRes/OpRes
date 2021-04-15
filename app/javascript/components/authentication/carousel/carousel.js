import React from 'react';
import { Carousel } from 'react-bootstrap';
import CarouselImg from '../../../images/carousel-img.png';
import styled from 'styled-components';

export default function carousel() {
  const CarouselWrapper = styled.div`
    height: 100%;
    background-color: #040605;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    margin: 0 auto 50px;
    .carousel {
      height: 30%;
      .carousel-control-prev, .carousel-control-next {
        display: none;
      }
      .carousel-indicators {
        bottom: 20px;
      }
      .carousel-inner {
        position: relative;
        height: 100%;
        .carousel-item {
          height: 80%;
          .carousel-caption {
            color: #fff;
            width: 50%;
            margin: 0 auto;
            h3 {
              font-size: 14px;
              margin-bottom: 20px;
              font-weight: 600;
            }
            p {
              font-size: 12px;
              font-weight: 400;
            }
          }
        }
      }
      .carousel-indicators {
        li {
          width: 7px;
          height: 7px;
          border: 1px solid #fff;
          border-radius: 100px;
          background: transparent;
        }
        li.active {
          background: #fff;
        }
      }
    }
    @media (max-width: 768px) {
      display: none;
    }
  `
  const ImgWrapper = styled.div`
    max-width: 500px;
    margin: 0 auto;
  ` 
  return (
    <CarouselWrapper>
      <ImgWrapper>
        <img src={CarouselImg} className="w-100"/>
      </ImgWrapper>
      <Carousel>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Our customers get instant insights into their resilience gaps, accross mission critical customer journeys</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Our customers get instant insights into their resilience gaps, accross mission critical customer journeys</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Our customers get instant insights into their resilience gaps, accross mission critical customer journeys</p>
          </Carousel.Caption>
        </Carousel.Item>
      </Carousel>
    </CarouselWrapper>
  )
}

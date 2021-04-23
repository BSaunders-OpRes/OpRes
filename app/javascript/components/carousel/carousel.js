import React from 'react';
import CarouselImg from '../../images/carousel-img.png';
import {Carousel} from 'react-bootstrap';
export default function carousel() {
  return (
    <div className="carousel-styling">
      <div className="carousel-img">
        <img src={CarouselImg} className="w-100"/>
      </div>
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
    </div>
  )
}

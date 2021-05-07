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
            <p>Map business services, identify resilience gaps acrossyour estate andimprove service availability through scenario testing.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Identify 3rd & 4th party risks faster, resolve themend to end and addressregulatory concerns.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Understand cloud service provider concentration risksand assessworkload distribution.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Make informed architecture choices and increase resiliencefor yourcustomers.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>OOptimise vendor reporting & improve supplier managementto identify costsavings.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Instant insight</h3>
            <p>Provide business & technology risk insights to complianceteams andregulators.</p>
          </Carousel.Caption>
        </Carousel.Item>
      </Carousel>
    </div>
  )
}

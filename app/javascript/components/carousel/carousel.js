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
            <h3>Map Business Services End to End</h3>
            <p>Map business services, identify resilience gaps across your estate and improve service availability through scenario testing.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Understand Supplier Dependencies</h3>
            <p>Identify 3rd & 4th party risks faster, resolve them end to end and address regulatory concerns.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Visualise Workload Distribution</h3>
            <p>Understand cloud service provider concentration risks and assess workload distribution.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Optimise Architecture Choices</h3>
            <p>Make informed architecture choices and increase resilience for your customers.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Reduce Costs</h3>
            <p>Optimise vendor reporting & improve supplier management to identify cost savings.</p>
          </Carousel.Caption>
        </Carousel.Item>
        <Carousel.Item>
          <Carousel.Caption>
            <h3>Quantify & Control Resilience Risks</h3>
            <p>Provide business & technology risk insights to compliance teams and regulators.</p>
          </Carousel.Caption>
        </Carousel.Item>
      </Carousel>
    </div>
  )
}

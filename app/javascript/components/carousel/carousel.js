import React from 'react';
import CarouselImg from '../../images/carousel-img.png';

export default function carousel() {
  return (
    <div className="carousel-styling">
      <div className="carousel-img">
        <img src={CarouselImg} className="w-100"/>
      </div>
      <div className="carousel">
        <ul className="carousel-indicators">
          <li data-target="#demo" data-slide-to="0" className="active"></li>
          <li data-target="#demo" data-slide-to="1"></li>
          <li data-target="#demo" data-slide-to="2"></li>
        </ul>
        <div className="carousel-inner">
          <div className="carousel-item active">
            <div className="carousel-caption">
              <h3>Instant insight</h3>
              <p>Our customers get instant insights into their resilience gaps, accross mission critical customer journeys</p>
            </div>
          </div>
          <div className="carousel-item">
            <div className="carousel-caption">
            <h3>Instant insight</h3>
              <p>Our customers get instant insights into their resilience gaps, accross mission critical customer journeys</p>
            </div>
          </div>
          <div className="carousel-item">
            <div className="carousel-caption">
            <h3>Instant insight</h3>
              <p>Our customers get instant insights into their resilience gaps, accross mission critical customer journeys</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

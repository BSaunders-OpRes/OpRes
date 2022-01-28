# README

* What is OpRes

The financial services sector is under pressure to deliver great products and experiences to their customers, whilst maintaining operational resilience. 
Regulatory requirements, FinTechs, established competitors and the public cloud are bringing new and complex challenges. Whilst customers desire exceptional products that are always available, at the click of a button.

Balancing these demands across hundreds of important business services, technology systems, and suppliers without hindering operational resilience is a difficult and costly exercise.

OpRes is an open source framework that maps important business services end to end. So organisations can understand their operational resilience posture and demonstrate a pathway to remediation. It was initially created as a mult-tennent solution and hosted on Heroku. However, in January 2022 the project was released to the Open Source community to drive wider contribution to the project and support financial organisations with building a commong framework for building their operational resilience capabilities upon. 

* Dependencies
  - Ruby v2.7.1
  - Rails v6.0.3
  - PostgreSQL v13.3

* Development Environment
  - Run `yarn install` to install node packages.
  - Run `bundle install` to install gems.
  - Run `rake db:create db:migrate db:seed` to setup database.
  - Run `rails server` to start server.
  - Run `bundle exec sidekiq` in a new terminal tab for sidekiq.

* Deployment instructions
  - Merge the `develop` branch into the `master` branch for auto-deployment on Heroku.
  - Run migrations, tasks, etc manually through Heroku bash.

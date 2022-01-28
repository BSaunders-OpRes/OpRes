# README


<img width="935" alt="Screenshot 2022-01-28 at 17 19 08" src="https://user-images.githubusercontent.com/87425889/151592424-1ccc0b8d-de19-42b5-8f3e-75628188780c.png">


* What is OpRes?

The financial services sector is under pressure to deliver great products and experiences to their customers, whilst maintaining operational resilience. 
Regulatory requirements, FinTechs, established competitors and the public cloud are bringing new and complex challenges. Whilst customers desire exceptional products that are always available, at the click of a button.

Balancing these demands across hundreds of important business services, technology systems, and suppliers without hindering operational resilience is a difficult and costly exercise.

OpRes is an open source framework that maps important business services end to end. So organisations can understand their operational resilience posture and demonstrate a pathway to remediation. It was initially created as a mult-tennent solution and hosted on Heroku. However, in January 2022 the project was released to the Open Source community to drive wider contribution to the project and support financial organisations with building a commong framework for building their operational resilience capabilities upon. 

The framework was created to support firms in demonstrating compliance with the following operational resilience regulations:

SS1/21 Operational resilience: Impact tolerances for Important Business Services

PS21/3 Building Operational Resilience

FG16/5: Guidance For Firms Outsourcing To The ‘Cloud’ and Other Third Party IT Services


-------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- 



* What does OpRes Aim To Do? 

Map important business services, identify resilience gaps across your technology estate, and execute scenario testing.

Identify 3rd & 4th party supplier risks faster, resolve them end to end, and address regulatory concerns.

Understand cloud service provider concentration risks and assess workload distribution.  

Make informed architecture choices and increase the resilience of your important business services for customers.

Optimise vendor reporting & improve supplier performance. Whilst identifying cost savings and increasing system availability. 

Provide business & technology risk insights to compliance teams and regulators with automated dashboards.

-------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- 

This project consits of the initial code base for OpRes, along with the provisonal screen designs that were mocked-up for the application initial bootstraping. This project was started by Ben Saunders - https://www.linkedin.com/in/ben-saunders-24699558/

Feel free to drop him a message should you have any queries or questions about the project!

-------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- 

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

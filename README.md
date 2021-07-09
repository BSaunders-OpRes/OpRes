# README

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

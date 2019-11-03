# README

* Ruby version: 2.6.3

* System dependencies: Linux for crontab support

* Configuration:
  * `bundle install`
  * Add Twilio security keys to `config/secrets.yml`

* Database initialization
  * `rails db:migrate`
  * Optional: `rails db:seed`
    * This provides test data

* Services
  * Update cron job with `whenever --update-cron`

* Deployment instructions
  * Run `rails server`
  

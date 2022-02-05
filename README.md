# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  `2.7.3`

* System dependencies
  * `sqlite3`
  * `rails 7`
  * `redis`

* Database creation & initialization
```
bundle install
bundle exec rails db:setup && rails db:test:prepare
```

* How to run the test suite
`bundle exec rake spec`

* Services (job queues, cache servers, search engines, etc.)
Redis needs to be running in staging/production environments
`redis start`

* Deployment instructions
TBD

* How I created the app
  - rails new
  - rails g job send_shipment_confirmation

  - gem install rails
  - rails new freightroll
  - cp .ruby-* freightroll/
  - cd freightroll/
  - # added to Gemfile:: [factory_bot, rspec-rails, byebug, devise]
  - cp ../../../.rubocop.yml .
  - rm -rf test
  - bundle install
  - rails generate rspec:install
  - rails generate devise:install
  - rails generate devise User
  - rails generate scaffold Shipment user:references name:string company_name:string reference_number:string
  - rails g job send_mfa_code
  - rails g job send_shipment_confirmation
  - rails db:migrate && rails db:test:prepare
  - rake spec
  - cp -r app/views/shipments app/views/sessions
- edited/created:
    - app/controllers/authenticated_controller.rb
    - app/controllers/sessions_controller.rb
    - app/controllers/shipments_controller.rb
    - app/jobs/send_mfa_code_job.rb
    - app/jobs/send_shipment_confirmation_job.rb
    - app/models/user.rb
    - app/models/shipment.rb
    - app/views/layouts/application.html.erb
    - db/migrate/20220205003111_devise_create_users.rb
    - db/seeds.rb
    - config/routes.rb
    - config/initializers/devise.rb
    - README.md (this file)



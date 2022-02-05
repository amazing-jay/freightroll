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
  * `twilio [service]`

* Database creation & initialization
  ```
  bundle install
  bundle exec rails db:setup && rails db:test:prepare
  ```

* How to run the test suite
`bundle exec rake spec`

* How to start the server
  Redis needs to be running
  `redis-server start`

  Then: `foreman start`
  NOTE: sidekiq isn't playing nicely with rails 7

* Deployment instructions
  TBD

* How I created the app
  - gem install rails
  - rails new freightroll
  - cp .ruby-* freightroll/
  - cd freightroll/
  - # added to Gemfile:: [byebug, devise, foreman, factory_bot, rspec-rails, simple_ruby_service, sidekiq, twilio-ruby ]
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
    - app/services/send_sms.rb
    - app/views/layouts/application.html.erb
    - db/migrate/20220205003111_devise_create_users.rb
    - db/seeds.rb
    - config/credentials.yml.enc
    - config/initializers/devise.rb
    - config/initializers/inflections.rb
    - config/sidekiq.yml
    - config/routes.rb
    - Gemfile
    - Procfile
    - .gitignore

 - important routes
                                    root GET    /(.:format)                             sessions#index
                                         POST   /sessions(.:format)                     sessions#create
                             new_session GET    /sessions/new(.:format)                 sessions#new
                            edit_session GET    /sessions/:id/edit(.:format)            sessions#edit
                                         PATCH  /sessions/:id(.:format)                 sessions#update
                                         PUT    /sessions/:id(.:format)                 sessions#update
                               shipments GET    /shipments(.:format)                    shipments#index
                                         POST   /shipments(.:format)                    shipments#create
                            new_shipment GET    /shipments/new(.:format)                shipments#new


* Happy path test plan
  - request root_path, expect redirect to new_session
  - sign_in, then request root_path, expect redirect to new_shipment
  - request new_session, expect form elements rendered
  - request create_session with bad data, expect form elements rendered with bad data retained & error messages
  - request create_session with good data, expect redirect to edit_session
  - request edit_session, expect form elements rendered
  - request update_session with bad data, expect form elements rendered with bad data retained & error messages
  - request update_session with good data, expect redirect to new_shipment & user signed_in
  - request new_shipment, expect form elements rendered
  - request create_shipment with bad data, expect form elements rendered with bad data retained & error messages
  - request create_shipment with good data, expect redirect to show_shippment


* Final notes
  - rails 7 is borked
  - didn't have time to work on test suite
  - didn't bother pruning unnecessary actions/files (because rails borked)


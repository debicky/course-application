# Course-application

## Your own teaching platform! 

There are 3 types of users:
- Administrator - can access everything on the app. This role have additional features like:
  - All users enrollments, to keep an eye on who&when bought, left review and opinion on a course.
  - Activity, place where we can check all CRUD operations made on our app.
  - Users, adding&removing roles, checking if the email is confirmed, last sign up, sign in, courses and enrollments count.
  
* Ruby & Ruby on Rails version
  > 2.7.1 & 6.0.3 

* System dependencies
  > Ubuntu 18.04.4 LTS

gem 'bootstrap'
gem 'simple_form'
gem 'devise'
gem 'faker'
gem 'friendly_id'
gem 'ransack'
gem 'public_activity'
gem "rolify"
gem "pundit"
gem 'pagy'
gem 'rails-erd', group: :development
gem 'ranked-model'
gem "aws-sdk-s3", require: false
gem 'active_storage_validations'
gem 'image_processing'


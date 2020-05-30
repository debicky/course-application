# Course-application

## Your own teaching platform! 

There are 4 types of users:
1. Administrator - can access everything on the app. This role have additional features like:
  - *Enrollments*, to keep an eye on who&when bought, left review and opinion on a course.
  - *Activity*, place where we can check all CRUD operations made on our app.
  - *Users*, adding&removing roles, checking if the email is confirmed, last sign up, sign in, courses and enrollments count.
  - *Unapproved courses*, **admin has to approve course to make it accesible for students.**
2. Teacher  - ability to create, update, delete courses&course lessons.
  - *New course*, create a new course, add short and long description, logo image, level, language and price. Long description has rich_text. Except formating text, **you can add files to let your students download them (link_to in blob file**). **Teacher has to select "published" to let students enroll.**(As long as admin approved it already.) Course can't be deleted if there are enrolled students. Then teacher can add lessons to the course. Lessons also has rich_text functionality. **Visited lessons marked with green index**, navigation to previous and next lesson buttons,  **%percentage progress status of total lessons visited**.
  - *Your students*, list of students which enrolled to your courses. Teacher can check rating, review and progress of students. 
  - * Created courses*, list of all courses created so far. **Even if there are unapproved and unpublished.**
3. Student - can enroll to courses.
  - *Your courses*, - list of courses which belongs to user. 
  - *Pending review*, list of courses which belongs to user, where user didn't left rating and review so far. 
4. Unregistered guest - can visit root page, which contains list of: 
  - popular courses (based on ammount of total enrollments),
  - top rated (average of the rating),
  - latest courses (the newest added courses),
  - what our students want to say (reviews left by students).
  Can visit show page of courses, to check long description and and preview list of lessons. **Can't see lessons before enrolling to course**. Can read reviews left by other users related to this course. 
  
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


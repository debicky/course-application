# Course-application

## Your own teaching platform! 


### There are 4 types of users:

1. Unregistered guest -   Can visit show page of courses, to check long description and and preview list of lessons. **Can't see lessons before enrolling to course**. Can read reviews left by other users related to this course. **Can filter courses by their parameters(ability to choose multiple of them at once).** Can filter courses using search form in navbar, whatever page is it.
Can visit root page, which contains list of: 
   - popular courses (based on ammount of total enrollments),
   - top rated (average of the rating),
   - latest courses (the newest added courses),
   - what our students want to say (reviews left by students).
  
2. Student - can enroll to courses and see lessons related to it. Every single user gets that roll after signing up to the application.
  * *Continue learing*, - additional list on root page, with courses which belongs to user. **Shows up only after first enroll.**
  
    - *Your courses*, - list of courses which belongs to user. **Visited lessons marked with green index**, navigation buttons to previous and next lessons,  **%percentage progress status of total lessons visited**.
    - *Pending review*, list of courses which belongs to user, where user didn't left rating and review so far. 
  
3. Teacher  - ability to create, update, delete courses&course lessons. Every single user gets that roll after signing up to the application.
    - *New course*, create a new course, add short and long description, logo image, level, language and price. Long description has rich_text. Except formating text, **you can add files to let your students download them (link_to in blob file**). **Teacher has to select "published" to let students enroll.**(As long as admin approved it already.) Course can't be deleted if there are enrolled students. Then teacher can add lessons to the course. Lessons also has rich_text functionality. **Order of created lessons can be changed by drag & drop functionality.**
    - *Your students*, list of students which enrolled to your courses. Teacher can check rating, review and progress of students. **Can filter students.**
    - *Created courses*, list of all courses created so far. **Even if there are unapproved and unpublished.**
  
4. Administrator - can access everything on the app. This role have additional features like:
    - *Enrollments*, to keep an eye on who&when bought, left review and opinion on a course.
    - *Activity*, place where we can check all CRUD operations made on our app.
    - *Users*, adding&removing roles, checking if the email is confirmed, last sign up, sign in, courses and enrollments count.
    - *Unapproved courses*, **admin has to approve course to make it accesible for students.**


### Specs

* Ruby & Ruby on Rails version
  > 2.7.1 & 6.0.3 

* System dependencies
  > Ubuntu 18.04.4 LTS


### Used gems

1. gem 'bootstrap' 
   > easy solution for basic RWD layout. Card system used widely around application. Usefull navbar with dropdown buttons.

2. gem 'simple_form'
   > easier form managing. Ability to add bootstrap classes to all forms at once.
   
3. gem 'devise'
   > my favourite gem. Extra fast and easy authentication system. Various additional features like: trackable - user login count, IP, last time visited and many more, confirmable - sending email with confirmation instructions and lot more.
   
4. gem 'faker'
   > funny and useful gem to seed database. Used to create users, courses, lessons and comments.
   
5. gem 'friendly_id'
   > enhance your ordinary URLs. Insted of having courses/12345 we can have courses/titleofmycourse.
   
6. gem 'ransack'
   > filter and search functionality. Gem used widely to filter all courses. Ability to sort tables by clicking on their names.
   
7. gem 'public_activity'
   > gem witch allows to track CRUD operations made by user. It lets me to do activity tab for admin.
   
8. gem "rolify"
   > thanks to this gem, after sign up user already got "Teacher" and "Student" role.
   
9. gem "pundit"
   > Combined with rolify gaves me easy to use authorization system.
   
10. gem 'pagy'
   > fast and lightweight paggination feature. Easily used with bootstrap for better look.
   
11. gem 'rails-erd', group: :development
   > generates dragram based on your application model relationships. 
   
   PICTURE OF THIS DIAGRAM <<< 
   
12. gem 'ranked-model'
   > row sorting library. Combined with jQuery sortable library let me make drag and drop feature for editing order of lessons preview list.
   
13. gem "aws-sdk-s3"
   > needed to upload files to Amazon S3 bucket in production.
   
14. gem 'active_storage_validations'
   > needed for creating validations like file size or presence for active_storage files uploaded to application.
   
15. gem 'image_processing'
   > combined with active_storage and active_storage_validations. Ability to resize picture "the ruby way".


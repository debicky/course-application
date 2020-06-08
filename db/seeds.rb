if User.find_by_email('admin@admin.com').nil?
  user = User.new(
    email: "admin@admin.com",
    password: "admin@admin.com",
    password_confirmation: "admin@admin.com",
    confirmed_at: Time.now
  )
  user.save
end

if User.find_by_email('studentteacher@example.com').nil?
  studentteacher = User.create(email: 'studentteacher@example.com', password: 'studentteacher@example.com', password_confirmation: 'studentteacher@example.com', confirmed_at: Time.now)
  #studentteacher.skip_confirmation!
  studentteacher.add_role(:teacher) unless studentteacher.has_role?(:teacher)
  studentteacher.add_role(:student) unless studentteacher.has_role?(:student)
end

if User.find_by_email('student@example.com').nil?
  student = User.create(email: 'student@example.com', password: 'student@example.com', password_confirmation: 'student@example.com', confirmed_at: Time.now)
  #student.skip_confirmation!
  student.add_role(:student) unless student.has_role?(:student)
end



PublicActivity.enabled = false


5.times do
  c = Course.create(
    title: Faker::Educator.course_name,
    short_description: Faker::Quote.famous_last_words,
    description: Faker::Hipster.paragraph(sentence_count: 5, supplemental: false, random_sentences_to_add: 3),
    user: User.find_by(email: "admin@admin.com"),
    language: [ "English", "Polish", "Spanish"].sample,
    level: [ "Beginner", "Intermediate", "Advanced"].sample,
    price: Faker::Number.between(from: 10, to: 200),
    approved: true,
    published: true,
  )
  c.logo.attach(io: File.open('app/assets/images/logo.png'), filename: "#{Faker::Number.between(from: 10, to: 200)}_logo.jpg")
end


5.times do
  c = Course.create(
    title: Faker::Educator.course_name,
    short_description: Faker::Quote.famous_last_words,
    description: Faker::Hipster.paragraph(sentence_count: 5, supplemental: false, random_sentences_to_add: 3),
    user: User.find_by(email: "studentteacher@example.com"),
    language: [ "English", "Polish", "Spanish"].sample,
    level: [ "Beginner", "Intermediate", "Advanced"].sample,
    price: Faker::Number.between(from: 10, to: 200),
    approved: true,
    published: true,
  )
  c.logo.attach(io: File.open('app/assets/images/logo.png'), filename: "#{Faker::Number.between(from: 10, to: 200)}_logo.jpg")
end



Course.all.each do |course|
  10.times do
    Lesson.create!([{
      title: Faker::Lorem.sentence(word_count: 3),
      content: Faker::Lorem.sentence,
      course: course
    }])
  end


  Enrollment.create!([{
    user: User.find_by(email: "student@example.com"),
    course: course,
    price: course.price
  }])

end

PublicActivity.enabled = true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create!(
  email: "test@test.pl",
  password: "password",
  password_confirmation: "password"
)


10.times do 
  Course.create!(
    title: Faker::Educator.course_name,
    description: Faker::Hipster.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 3),
    user_id: User.first.id,
    short_description: Faker::Quote.famous_last_words,
    language: [ "English", "Polish", "Spanish"].sample,
    level: [ "Beginner", "Intermediate", "Advanced"].sample,
    price: Faker::Number.between(from: 10, to: 200)


  )
end
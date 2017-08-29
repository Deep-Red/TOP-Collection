# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
16.times do |i|
  first_name, last_name = Faker::Name.name.split(" ")
  email = "fake#{i+1}@example.com"
  password = "password"

  user = User.new(first_name: first_name,
                last_name: last_name,
                email: email,
                password: password,
                password_confirmation: password
                )
  user.skip_confirmation!
  user.save!
end
5.times do |i|
  first_name, last_name = Faker::Name.name.split(" ")
  email = "example-#{i+1}@railstutorial.org"
  password = "password"

  user = User.create!(first_name: first_name,
                last_name: last_name,
                email: email,
                password: password,
                password_confirmation: password
                )
  user.skip_confirmation!
  user.save!
end

2.times do |n|
  a = User.all
  a.each do |u|
    u.posts.create(content: Faker::Lorem.paragraphs(1), title: "#{u.first_name} post #{n}")
  end
  a.each do |u|
    u.posts.create(content: Faker::Hipster.paragraphs(1), title: "#{u.first_name} another post #{n}")
  end
end

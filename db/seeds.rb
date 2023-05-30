# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

SEED_PASSWORD = 'Pass123'.freeze

if Rails.env.development?

  puts 'Seeds starting...'
  puts 'Destroying previous objects...'

  User.destroy_all

  chris = User.create!(password:'kiwi123', email: 'chris@mail.com', name: 'Christian', last_name: 'Zamora', admin: true)

  (1..6).each do |i|
    user = User.create_with(
      password: SEED_PASSWORD,
      admin: false,
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      nick_name: Faker::Fantasy::Tolkien.character,
      interest: { activity: Faker::Hobby.activity, activity_2: Faker::Hobby.activity }
    ).find_or_create_by!(email: "#{Faker::Name.first_name}@mail.com")
  end
  puts 'seed file ran succesfully!, bye'
end

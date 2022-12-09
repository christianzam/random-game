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

  Member.destroy_all
  User.destroy_all
  Gift.destroy_all
  u = User.create!(password:'kiwi123', email: 'chris@mail.com', admin: true)

  (1..3).each do |i|
    user = User.create_with(
      password: SEED_PASSWORD,
      admin: false,
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      nick_name: Faker::Fantasy::Tolkien.character,
      interest: { activity: Faker::Hobby.activity, activity_2: Faker::Hobby.activity }
    ).find_or_create_by!(email: "#{Faker::Name.first_name}@mail.com")
  end

  3.times do
    user = User.all.sample
    Member.create!(
      email: "#{Faker::Name.first_name}@seed.com",
      nickname: Faker::Fantasy::Tolkien.character,
      give_to: user.name,
      user_id: user.id
    )
  end

  10.times do
    Gift.create!(
      name: Faker::Appliance.equipment,
      description: "#{Faker::Appliance.brand} #{Faker::Lorem.paragraph }",
      price: Faker::Commerce.price
    )
  end

  puts 'seed file ran succesfully!, bye'
end

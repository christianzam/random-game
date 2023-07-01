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

  chris = User.create!(password: SEED_PASSWORD, email: 'chris@mail.com', name: 'Christian', last_name: 'Zamora', nick_name: 'Chris', admin: true)
  players = %w(Eduardo Axel AxlChristian Enrique Patricio Diego)

  players.each_with_index do |player, index|
    nicknames = %w(Lalo Erinu Tinoco Kike Pato Diego)

    user = User.create_with(
      password: SEED_PASSWORD,
      admin: false,
      name: player,
      last_name: Faker::Name.last_name,
      nick_name: nicknames[index],
      interest: { activity: Faker::Hobby.activity, activity_2: Faker::Hobby.activity }
    ).find_or_create_by!(email: "#{player}@mail.com")
  end
  puts 'seed file ran succesfully!, bye'
end

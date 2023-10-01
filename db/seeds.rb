require 'faker'

SEED_PASSWORD = 'Pass123'.freeze

if Rails.env.development?
  puts 'Seeds starting...'
  puts 'Destroying previous records...'
  User.destroy_all
  PlayerGameResult.destroy_all
  Game.destroy_all
  Tournament.destroy_all
  puts 'Records destroyed...'

  users = { 
    Lalo: { name: "Eduardo", last_name: '' }, 
    Erinu: { name: 'AxelMohammed', last_name: ''},
    Tinok: { name: 'AxelCristian', last_name: 'Tinoco'},
    Pato: { name: 'Patricio', last_name: 'Rodriguez'},
    Kike: { name: 'Enrique', last_name: '' },
    Diego: { name: 'Diego', last_name: '' },
    Serg: { name: 'Sergio', last_name: '' },
    Majo: { name: 'MariJose', last_name: '' },
    Manu: { name: 'Manuel', last_name: '' },
    Alex: { name: 'Alejandro', last_name: '' },
    Cris: { name: 'Cristina', last_name: '' },
    Xoch: { name: 'Xochitl', last_name: ''  },
    Chris: { name: 'Christian', last_name: 'Zamora', admin: true }
  }
  
  puts '...Creating Users'

  users.each do |key, value|
    last_name = ["Tinoco", "Rodriguez", "Zamora"].include?(value[:last_name]) ? value[:last_name] : Faker::Name.last_name
                    
    admin = value[:last_name].include?('Zamora') ? true : false

    User.create_with(
      password: SEED_PASSWORD,
      admin: admin,
      name: value[:name],
      last_name: last_name,
      nick_name: key,
      interest: { activity: Faker::Hobby.activity, activity_2: Faker::Hobby.activity }
    ).find_or_create_by!(email: "#{key}@mail.com")
  end

  puts 'Examples users:'
  puts User.first.inspect
  puts User.find_by(name: 'Christian').inspect

  puts 'Creating Tournaments'
  tournaments = {
    "Mini Basket" => { 
      start_date: '1st June 2023'.to_date,
      end_date: '31 Dec 2023'.to_date,
      period_tournament: true
     },

     "Office Darts" => {
      start_date: '1st Sept 2023'.to_date,
      end_date: '31 Dec 2023'.to_date,
      period_tournament: true
     }
  }

  tournaments.each do |k, v|
    tournament = Tournament.create!(
      name: k,
      start_date: v[:start_date],
      end_date: v[:end_date],
      period_tournament: v[:period_tournament]
    )
  end
  puts 'Tournaments created'
  puts 'Example tournament'
  puts Tournament.last.inspect

  puts 'seed file ran succesfully!, bye'
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it "returns a user full name" do
    user = User.create(name:'Chris', last_name:'Zamora')

    expect(user.full_name).to eq 'Chris Zamora'
  end

  it "nick_name must be unique" do
    user_1 = User.create(name:'Chris', last_name:'Zamora', nick_name: 'ChrisMan')
    user_2 = User.create(name:'Max', last_name:'Turner', nick_name: 'ChrisMan')

    expect(user_1.nick_name).not_to be user_2.nick_name
  end

  it "name must be more than 2 characters" do
    user = User.create(name:'Ch', last_name:'Zamora')

    expect(user.name.size).to be >= 2
  end
end

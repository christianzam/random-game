require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'member email cannot be nil' do
    member = Member.create(email: 'chris@mail.com', nickname: 'ChrisMan', give_to: 'Mitchell')

    expect(member.email).not_to be_nil
  end

  it 'member nickname must be unique' do
    member_1 = Member.create(email: 'chris@mail.com', nickname: 'ChrisMan', give_to: 'Mitchell')
    member_2 = Member.create(email: 'chris_man@mail.com', nickname: 'ChrisMan', give_to: 'Alan')

    expect(member_1.nickname).not_to be member_2.nickname
  end

  it 'interests must have activity key' do
    member = Member.create(email: 'chris@mail.com', nickname: 'ChrisMan', give_to: 'Mitchell', interests:{activity: 'Cooking', activity_2: 'Yoga'})

    expect(member.interests).to have_key("activity")
  end
end

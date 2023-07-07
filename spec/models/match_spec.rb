# == Schema Information
#
# Table name: matches
#
#  id          :bigint           not null, primary key
#  date        :date
#  week_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Match, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

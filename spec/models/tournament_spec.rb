# == Schema Information
#
# Table name: tournaments
#
#  id                :bigint           not null, primary key
#  end_date          :date
#  name              :string
#  period_tournament :boolean
#  start_date        :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe Tournament, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

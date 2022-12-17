class Group < ApplicationRecord
  serialize :members, Array
end

class Santa < ApplicationRecord
  belongs_to :user, optional: true
end

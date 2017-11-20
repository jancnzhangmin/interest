class Takeout < ApplicationRecord
  belongs_to :user
  belongs_to :card,optional: true
end

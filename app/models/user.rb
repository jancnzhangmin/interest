class User < ApplicationRecord
  belongs_to :region
  belongs_to :interestversion
  has_many :deposits
  has_many :capitals
  has_many :cards
end

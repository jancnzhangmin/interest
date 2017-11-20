class User < ApplicationRecord
  belongs_to :region
  belongs_to :interestversion
  has_many :deposits
  has_many :capitals
  has_many :cards
  has_many :takeouts
  has_many :srelations
  has_many :finterests
end

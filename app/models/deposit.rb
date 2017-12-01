class Deposit < ApplicationRecord
  belongs_to :deposittypedef
  belongs_to :user
end

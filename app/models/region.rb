class Region < ApplicationRecord
  has_many :users
  has_many :childrens, class_name: "Region", foreign_key: "up_id"
  belongs_to :parent, class_name: "Region", foreign_key: "up_id",optional: true
end

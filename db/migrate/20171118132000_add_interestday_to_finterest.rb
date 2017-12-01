class AddInterestdayToFinterest < ActiveRecord::Migration[5.0]
  def change
    add_column :finterests, :interestday, :datetime
  end
end

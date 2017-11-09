class AddCapitalToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :capital, :float
  end
end

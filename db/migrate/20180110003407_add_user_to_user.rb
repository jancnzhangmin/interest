class AddUserToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user, :string
  end
end

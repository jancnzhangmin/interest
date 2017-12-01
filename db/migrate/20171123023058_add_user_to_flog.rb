class AddUserToFlog < ActiveRecord::Migration[5.0]
  def change
    add_column :flogs, :user, :string
  end
end

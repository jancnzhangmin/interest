class AddUserToDeposit < ActiveRecord::Migration[5.0]
  def change
    add_column :deposits, :user, :string
  end
end

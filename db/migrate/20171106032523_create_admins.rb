class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :login
      t.string :password_digest
      t.string :auth
      t.integer :status

      t.timestamps
    end
  end
end

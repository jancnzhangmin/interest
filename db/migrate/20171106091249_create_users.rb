class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :region_id
      t.integer :interestversion_id
      t.string :username
      t.integer :sex
      t.string :address
      t.string :tel
      t.text :content

      t.timestamps
    end
  end
end

class CreateFinterests < ActiveRecord::Migration[5.0]
  def change
    create_table :finterests do |t|
      t.integer :user_id
      t.float :amount
      t.integer :incapitalstatus
      t.integer :interesttype

      t.timestamps
    end
  end
end

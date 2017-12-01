class CreateTakeouts < ActiveRecord::Migration[5.0]
  def change
    create_table :takeouts do |t|
      t.integer :user_id
      t.string :ordernumber
      t.float :amount
      t.integer :red
      t.integer :redid
      t.text :content

      t.timestamps
    end
  end
end

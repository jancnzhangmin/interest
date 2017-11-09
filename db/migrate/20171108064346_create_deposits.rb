class CreateDeposits < ActiveRecord::Migration[5.0]
  def change
    create_table :deposits do |t|
      t.integer :deposittypedef_id
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

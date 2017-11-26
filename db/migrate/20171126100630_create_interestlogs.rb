class CreateInterestlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :interestlogs do |t|
      t.integer :user_id
      t.float :amount

      t.timestamps
    end
  end
end

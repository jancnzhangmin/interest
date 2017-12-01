class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :name
      t.string :bankdeposit
      t.string :bankaccount

      t.timestamps
    end
  end
end

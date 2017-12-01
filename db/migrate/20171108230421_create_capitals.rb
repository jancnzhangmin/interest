class CreateCapitals < ActiveRecord::Migration[5.0]
  def change
    create_table :capitals do |t|
      t.integer :user_id
      t.float :capital

      t.timestamps
    end
  end
end

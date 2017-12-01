class CreateSrelations < ActiveRecord::Migration[5.0]
  def change
    create_table :srelations do |t|
      t.integer :relationdef_id
      t.integer :user_id
      t.string :name
      t.string :tel
      t.string :address
      t.string :content

      t.timestamps
    end
  end
end

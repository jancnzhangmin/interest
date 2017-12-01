class CreateRelationdefs < ActiveRecord::Migration[5.0]
  def change
    create_table :relationdefs do |t|
      t.string :relation

      t.timestamps
    end
  end
end

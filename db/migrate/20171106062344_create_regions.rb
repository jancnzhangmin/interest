class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.string :region
      t.references :up

      t.timestamps
    end
  end
end

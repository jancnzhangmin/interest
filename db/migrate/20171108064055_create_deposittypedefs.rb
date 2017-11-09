class CreateDeposittypedefs < ActiveRecord::Migration[5.0]
  def change
    create_table :deposittypedefs do |t|
      t.string :depostitype

      t.timestamps
    end
  end
end

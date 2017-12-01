class CreateFlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :flogs do |t|
      t.string :log
      t.string :logtype

      t.timestamps
    end
  end
end

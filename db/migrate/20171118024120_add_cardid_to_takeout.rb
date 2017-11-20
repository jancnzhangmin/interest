class AddCardidToTakeout < ActiveRecord::Migration[5.0]
  def change
    add_column :takeouts, :card_id, :integer
  end
end

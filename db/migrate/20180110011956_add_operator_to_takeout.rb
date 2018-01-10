class AddOperatorToTakeout < ActiveRecord::Migration[5.0]
  def change
    add_column :takeouts, :operator, :string
  end
end

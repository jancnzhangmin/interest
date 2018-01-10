class AddOperatorToDeposit < ActiveRecord::Migration[5.0]
  def change
    add_column :deposits, :operator, :string
  end
end

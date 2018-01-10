class AddOperatorToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :operator, :string
  end
end

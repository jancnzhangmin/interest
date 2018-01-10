class AddOperatorToSrelation < ActiveRecord::Migration[5.0]
  def change
    add_column :srelations, :operator, :string
  end
end

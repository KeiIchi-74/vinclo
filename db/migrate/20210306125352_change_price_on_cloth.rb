class ChangePriceOnCloth < ActiveRecord::Migration[6.0]
  def change
    change_column :cloths, :price, :string
  end
end

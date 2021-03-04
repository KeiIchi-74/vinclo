class ChangePriceOnReview < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :price, :string
  end
end

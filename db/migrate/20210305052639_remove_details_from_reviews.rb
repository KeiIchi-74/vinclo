class RemoveDetailsFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :cloth_name, :string
    remove_column :reviews, :price, :integer
  end
end

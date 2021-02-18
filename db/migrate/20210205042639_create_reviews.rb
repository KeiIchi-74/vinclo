class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string  :title, null: false
      t.string  :cloth_name
      t.integer :price
      t.integer :score, null: false
      t.string  :text, null: false
      t.references :user, foreign_key: true
      t.references :cloth_store, foreign_key: true
      t.timestamps
    end
  end
end

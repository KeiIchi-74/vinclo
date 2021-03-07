class CreateCloths < ActiveRecord::Migration[6.0]
  def change
    create_table :cloths do |t|
      t.string  :cloth_name
      t.integer :price
      t.references :review, foreign_key: true
      t.timestamps
    end
  end
end

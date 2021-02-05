class CreateClothStores < ActiveRecord::Migration[6.0]
  def change
    create_table :cloth_stores do |t|
      t.string  :name,      null: false
      t.string  :name_kana, null: false
      t.string  :postcode,  null: false
      t.integer :prefecture_code
      t.string  :address_city
      t.string  :address_street
      t.float   :latitude
      t.float   :longitude
      t.timestamps
    end

    add_index :cloth_stores, [:latitude, :longitude]
  end
end

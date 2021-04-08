# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cloth_stores = []
reviews = []
47.times do |prefecture_num|
  3.times do |i|
    cloth_store = ClothStore.create(
      name: "店舗#{i + 1}",
      name_kana: "テンポ",
      postcode: "123-4567",
      prefecture_code: prefecture_num + 1,
      )
    cloth_stores << cloth_store
    review = Review.create(
      user_id: 1,
      cloth_store_id: cloth_store.id,
      title: "店舗#{i + 1}に行ってきました!",
      score: 3,
      text: "気さくな店員さんや、豊富なバリエーションの古着があって最高でした!気さくな店員さんや、豊富なバリエーションの古着があって最高でした!気さくな店員さんや、豊富なバリエーションの古着があって最高でした!気さくな店員さんや、豊富なバリエーションの古着があって最高でした!気さくな店員さんや、豊富なバリエーションの古着があって最高でした!気さくな店員さんや、豊富なバリエーションの古着があって最高でした!気さくな店員さんや、豊富なバリエーションの古着があって最高でした!",
    )
    reviews << review
  end
end

ClothStore.import cloth_stores
Review.import reviews
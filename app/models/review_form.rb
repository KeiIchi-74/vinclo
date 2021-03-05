class ReviewForm
  include ActiveModel::Model
  attr_accessor :title, :score, :text, :user_id, :cloth_store_id,
                :cloth_name, :price, :review_id, :review_images

  with_options presence: true do
    validates :score
    validates :title
    validates :text
  end

  validates :price, format: {
    with: /\A\d+\z/,
    message: 'を半角数字で入力してください。',
    allow_blank: true
  }

  def save(image_files)
    review = Review.create(
      title: title,
      score: score,
      text: text,
      user_id: user_id,
      cloth_store_id: cloth_store_id
    )
    image_files&.each do |image_file|
      review.review_images.attach(image_file)
    end

    return if cloth_name.empty? && price.empty?

    Cloth.create(
      cloth_name: cloth_name,
      price: price,
      review_id: review.id
    )
  end
end

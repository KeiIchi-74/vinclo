class ReviewForm < FormBase
  DEFAULT_ITEM_COUNT = 4
  attr_accessor :title, :score, :text, :user_id, :cloth_store_id,
                :review_images, :cloths

  with_options presence: true do
    validates :score
    validates :title
    validates :text
  end

  def initialize(attributes = {})
    super attributes
    self.cloths = DEFAULT_ITEM_COUNT.times.map { Cloth.new } unless cloths.present?
  end

  def cloths_attributes=(attributes)
    self.cloths = attributes.map do |_, cloths_attributes|
      Cloth.new(cloths_attributes)
    end
  end

  def valid?
    valid_cloths = target_cloths.map(&:valid?).all?
    super && valid_cloths
  end

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

    Cloth.transaction do
      target_cloths.each do |cloth|
        cloth.review_id = review.id
        cloth.save! unless cloth.cloth_name.empty? && cloth.price.empty?
      end
    end
  end

  private
  
  def target_cloths
    cloths.select { |cloth| cloth.register.include?('1') }
  end
end

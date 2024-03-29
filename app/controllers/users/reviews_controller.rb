class Users::ReviewsController < Users::ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @prefecture = JpPrefecture::Prefecture.find(code: params[:id])
    @reviews = Review.find_by_store_prefecture(params).order(created_at: :desc).page(params[:page]).per(20)
    @cities = Array.new(16, '市区町村')
  end

  def new
    @cloth_store = ClothStore.find_by(id: params[:format])
    @review_form = ReviewForm.new
    @review = Review.new
  end

  def create
    @cloth_store = ClothStore.find_by(id: params[:format])
    @review_form = ReviewForm.new(review_form_params)
    @review = Review.new
    @register_count = register_count
    return attach_image(@review) unless @review_form.valid?

    @review_form.save(uploaded_images)
    ActiveStorage::Blob.unattached.find_each(&:purge)
    flash[:notice] = 'レビューを投稿しました。'
    redirect_to cloth_store_path(@cloth_store.id)
  end

  def upload_image
    image_blob = create_blob(params[:image])
    respond_to do |format|
      format.json { render json: { image_id: image_blob.id } }
    end
  end

  def close
    ActiveStorage::Blob.unattached.find_each(&:purge)
  end

  def show_more_text
    @review = Review.find(params[:format])
  end

  private

  def review_form_params
    params.require(:review_form).permit(
      :score,
      :title,
      :text,
      review_images: [],
      cloths_attributes: Cloth::REGISTRABLE_ATTRIBUTES
    ).merge(
      cloth_store_id: @cloth_store.id,
      user_id: current_user.id
    )
  end

  def uploaded_images
    review_form_params[:review_images]&.map { |id| ActiveStorage::Blob.find(id) }
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload!(
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
    )
  end

  def attach_image(review)
    image_files = []
    review_form_params[:review_images]&.each do |id|
      image_files << ActiveStorage::Blob.find(id)
    end
    image_files.each do |image_file|
      review.review_images.attach(image_file)
    end
  end

  def register_count
    count = 0
    review_form_params['cloths_attributes'].each do |_, cloth|
      count += 1 if cloth['register'].include?('1')
    end
    count
  end
end

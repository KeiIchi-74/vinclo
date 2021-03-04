class Users::ReviewsController < Users::ApplicationController
  def index
    @prefecture = JpPrefecture::Prefecture.find(code: params[:id])
    @reviews = Review.find_by_store_prefecture(params).order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    @review = Review.new
    @cloth_store = ClothStore.find_by(id: params[:format])
  end

  def create
    @cloth_store = ClothStore.find_by(id: params[:format])
    @review = Review.new(review_params)
    return unless @review.save

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

  def review_params
    params.require(:review).permit(
      :cloth_name,
      :price,
      :score,
      :title,
      :text
    ).merge(review_images: uploaded_images, cloth_store_id: @cloth_store.id, user_id: current_user.id)
  end

  def uploaded_images
    params[:review][:review_images]&.map { |id| ActiveStorage::Blob.find(id) }
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload!(
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
    )
  end
end

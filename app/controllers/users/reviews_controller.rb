class Users::ReviewsController < Users::ApplicationController
  def create
    @cloth_store = ClothStore.find_by(id: params[:format])
    @address = @cloth_store.address_display
    gon.cloth_store = @cloth_store
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
      ActiveStorage::Blob.unattached.find_each(&:purge)
    else
      render template: 'users/cloth_stores/show'
    end
  end

  def upload_image
    image_blob = create_blob(params[:image])
    respond_to do |format|
      format.json { render json:{ image_id: image_blob.id } }
    end
  end

  private 

  def review_params
    params.require(:review).permit(
      :cloth_name,
      :price,
      :score,
      :title,
      :text
    ).merge(images: uploaded_images, cloth_store_id: @cloth_store.id, user_id: current_user.id)
  end

  def uploaded_images
    params[:review][:images].map{|id| ActiveStorage::Blob.find(id)} if params[:review][:images]
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload!(
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
    )
  end
end
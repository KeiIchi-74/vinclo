class Users::ClothStoresController < Users::ApplicationController
  def new
    @review = Review.new
    @cloth_store = ClothStore.new
  end

  def create
    @cloth_store = ClothStore.new(cloth_store_params)
    if @cloth_store.save
      redirect_to root_path
      flash[:notice] = '店舗情報を登録しました。'
    else
      render :new
    end
  end

  def show
    @review = Review.new
    @cloth_store = ClothStore.find(params[:id])
    @address = @cloth_store.address_display
    gon.latitude = @cloth_store.latitude
    gon.longitude = @cloth_store.longitude
  end

  private

  def cloth_store_params
    params.require(:cloth_store).permit(
      :name,
      :name_kana,
      :postcode,
      :prefecture_code,
      :address_city,
      :address_street
    )
  end
end

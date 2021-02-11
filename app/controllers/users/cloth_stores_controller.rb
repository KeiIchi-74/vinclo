class Users::ClothStoresController < Users::ApplicationController
  def new
    @cloth_store = ClothStore.new
  end

  def create
    @cloth_store = ClothStore.new(cloth_store_params)
    if @cloth_store.save
      redirect_to root_path
    else
      render :new
    end
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

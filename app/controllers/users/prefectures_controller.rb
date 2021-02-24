class Users::PrefecturesController < Users::ApplicationController
  include JpPrefecture
  def show
    @prefecture = JpPrefecture::Prefecture.find(code: params[:id])
    @cloth_stores = ClothStore.includes(:reviews).where(prefecture_code: params[:id]).to_a
  end
end

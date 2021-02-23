class Users::PrefecturesController < Users::ApplicationController
  include JpPrefecture
  def show
    @prefecture = JpPrefecture::Prefecture.find_by(code: params[:id])
    @cloth_stores = ClothStore.includes(:review).where(prefecture_code: params[:id]).to_a
  end
end

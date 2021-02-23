class Users::PrefecturesController < Users::ApplicationController
  include JpPrefecture
  def show
    @prefecture = JpPrefecture::Prefecture.find(code: params[:id])
    @cloth_stores = ClothStore.where(prefecture_code: params[:id]).to_a
  end
end

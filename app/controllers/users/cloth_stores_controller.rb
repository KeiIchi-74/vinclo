class Users::ClothStoresController < Users::ApplicationController
  def new
    @cloth_store = ClothStore.new
  end
end
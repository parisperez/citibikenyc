class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.where(user_id: params[:user_id])
    render :index
  end


   def create
    @favorite = Favorite.new(favorites_params)
    current_user.favorites << @favorite
    if @favorite.save
      redirect_to user_path(current_user)
      # redirect_to user_favorites_path(current_user)

    else
      redirect_to user_path(current_user)
    end
  end

  private

# this is the white list engineering
  def favorites_params
    params.require(:favorite).permit(:address)
  end

  def favorite?
    favorites[user_id].present? == false
  end

end  





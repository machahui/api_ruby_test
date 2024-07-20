class FavoriteController < ApplicationController

  # before_action :set_favorite, only: [:show, :destroy]


  #GET /users
  def index
    favorite = Favorite.all
    render json: favorite, status: :ok
  end

  #POST /users
  def create
    favorite = Favorite.new(favorite_params)
    print favorite_params
    if favorite.save
      render json: favorite, status: :created
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  #DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def favorite_params
    params.require(:favorite).permit!
  end
end
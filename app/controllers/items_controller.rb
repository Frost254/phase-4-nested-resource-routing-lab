class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
      if params[:user_id]
        user = User.find(params[:user_id])
        item = Item.new(user_id: user.id)
        render json: item, include: :user, status: :created
      else
        render json: Item.new, include: :user
      end
  end

  private
  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

end

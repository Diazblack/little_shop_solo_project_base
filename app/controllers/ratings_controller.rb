class RatingsController < ApplicationController
  def new
    @o_item = OrderItem.find(params[:order_item_id])
    @rating = Rating.new
  end

  def create
    render file: 'errors/not_found', status: 404 if current_user.nil?
    params[:rating][:user_id] = current_user.id
    @o_item = OrderItem.find(params[:order_item_id])
    @order = @o_item.order
    @rating = @o_item.ratings.create(ratings_params)
    if @rating.save
      flash[:success] = "Review Was Created"
      redirect_to order_path(@order)
    else
      flash.now[:notice] = "Your Review Have Incomplete Fields"
      render :new
    end
  end

  def update
    require "pry"; binding.pry
  end
  private

  def ratings_params
    params.require(:rating).permit(:title, :description, :rate, :user_id)
  end
end

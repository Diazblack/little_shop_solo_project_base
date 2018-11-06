class RatingsController < ApplicationController
  def new
    require "pry"; binding.pry
    @order_item = OrderItem.find(params[:format])
    @order = @order_item.order
    @user = @order.user
    @rating = Rating.new
    @url = order_path(@order)
  end

  def create

  end
end

class RatingsController < ApplicationController
  def new
    @rating = Rating.new
    @url = order_path(@order)
  end

  def create

  end
end

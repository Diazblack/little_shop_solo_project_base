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
    order = Order.find(params[:order_id]) if params[:order_id]
    item = Item.find(params[:item_id]) if params[:item_id]
    rating = Rating.find(params[:rate_id])
    if current_admin?
      if params[:attribute] == 'active'
        rating.update(active: false)
        flash[:notice] = "Review Disable"
      else
        rating.update(active: true)
        flash[:notice] = "Review Enable"
      end
      redirect_to item_path(item)
    else
      if params[:attribute] == 'active'
        rating.update(active: false)
        flash[:notice] = "Review Disable"
        redirect_to order_path(order)
      end
    end
  end
  private

  def ratings_params
    params.require(:rating).permit(:title, :description, :rate, :user_id)
  end
end

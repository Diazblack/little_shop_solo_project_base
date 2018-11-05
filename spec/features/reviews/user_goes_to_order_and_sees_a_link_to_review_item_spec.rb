require 'rails_helper'

describe 'items review' do
  before(:each) do
    @user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @merchant = create(:merchant)
    @item_1, @item_2, @item_3, @item_4, @item_5 = create_list(:item, 5, user: @merchant)

    @order_1 = create(:order, user: @user)
    create(:order_item, order: @order_1, item: @item_1)
    create(:order_item, order: @order_1, item: @item_2)

    @order_2 = create(:completed_order, user: @user)
    create(:fulfilled_order_item, order: @order_2, item: @item_2)
    create(:fulfilled_order_item, order: @order_2, item: @item_3)

    @order_3 = create(:cancelled_order, user: @user)
    create(:order_item, order: @order_3, item: @item_3)
    create(:order_item, order: @order_3, item: @item_4)

    @order_4 = create(:disabled_order, user: @user)
    create(:order_item, order: @order_4, item: @item_1)
    create(:order_item, order: @order_4, item: @item_3)
  end

  describe 'user goes to it orders and see a bottom to rate items' do

    it 'should see a link in completed orders' do
      visit profile_orders_path(@user)

      click_on "Order #{@order_2.id}"

      expect(page).to have_link("Review Item #{@item_2.name}")

    end
  end
end

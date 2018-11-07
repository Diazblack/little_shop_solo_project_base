require 'rails_helper'

describe 'Can rate 1 item per order' do
  before(:each) do
    @user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @merchant = create(:merchant)
    @item_1, @item_2, @item_3, @item_4, @item_5 = create_list(:item, 5, user: @merchant)

    @order_1 = create(:order, user: @user)
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2)

    @order_2 = create(:completed_order, user: @user)
    @order_item_3 = create(:fulfilled_order_item, order: @order_2, item: @item_2)
    @order_item_4 = create(:fulfilled_order_item, order: @order_2, item: @item_3)

    @rate = create(:rating, user: @user, order_item: @order_item_3)

    @order_3 = create(:cancelled_order, user: @user)
    @order_item_5 = create(:order_item, order: @order_3, item: @item_3)
    @order_item_6 = create(:order_item, order: @order_3, item: @item_4)

    @order_4 = create(:disabled_order, user: @user)
    @order_item_7 = create(:order_item, order: @order_4, item: @item_1)
    @order_item_8 = create(:order_item, order: @order_4, item: @item_3)
  end

   it 'should not see the the rate link when it rate the item' do

     visit profile_orders_path(@user)

     click_on "Order #{@order_2.id}"

     expect(page).to_not have_link("Review Item #{@item_2.name}")
   end

   it 'if user has a review sees a button to deactivated te rating' do

     visit profile_orders_path(@user)

     click_on "Order #{@order_2.id}"

     click_on "Disable Review"

     expect(current_path).to eq(order_path(@order_2))

     expect(page).to have_content("Review Disable")

     expect(page).to_not have_content(@rate.title)
     expect(page).to_not have_content(@rate.description)
   end
end

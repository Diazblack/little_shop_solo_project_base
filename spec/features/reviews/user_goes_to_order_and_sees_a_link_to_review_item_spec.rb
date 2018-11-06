require 'rails_helper'

describe 'items review' do
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

    @order_3 = create(:cancelled_order, user: @user)
    @order_item_5 = create(:order_item, order: @order_3, item: @item_3)
    @order_item_6 = create(:order_item, order: @order_3, item: @item_4)

    @order_4 = create(:disabled_order, user: @user)
    @order_item_7 = create(:order_item, order: @order_4, item: @item_1)
    @order_item_8 = create(:order_item, order: @order_4, item: @item_3)
  end

  describe 'user goes to it orders and see a bottom to rate items and goes to the review form' do

    it 'should see a link in completed orders' do
      visit profile_orders_path(@user)

      click_on "Order #{@order_2.id}"

      expect(page).to have_link("Review Item #{@item_2.name}")

      click_on "Review Item #{@item_2.name}"

      expect(current_path).to eq(new_order_item_rating_path(@order_item_3))

    end
    it 'if order is cancel user shouldnt see a link in completed orders' do
      visit profile_orders_path(@user)

      click_on "Order #{@order_3.id}"

      expect(page).to_not have_link("Review Item #{@item_3.name}")
      expect(page).to_not have_link("Review Item #{@item_4.name}")

    end

    it 'user can go to the ratings form page and create a review' do
      visit order_path(@order_2)

      click_on "Review Item #{@item_2.name}"

      expect(current_path).to eq(new_order_item_rating_path(@order_item_3))

      title_1 = "Broken in two days"
      description_1 = "Super Cheap quality"

      fill_in :rating_title, with: title_1
      fill_in :rating_description, with: description_1
      fill_in :rating_rate, with: 1

      click_on "Create Rating"

      expect(current_path).to eq(order_path(@order_2))

      expect(Rating.last.title).to eq(title_1)
      expect(Rating.last.description).to eq(description_1)

    end

  end
end

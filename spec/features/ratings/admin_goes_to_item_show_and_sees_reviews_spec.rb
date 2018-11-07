require 'rails_helper'

describe 'Admin goes to item show and sees reviews' do
  before(:each) do
    @user_1 = create(:user, role: 0)
    @user_2 = create(:user, role: 0)
    @user_3 = create(:user, role: 0)

    @admin = create(:user, role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    @merchant = create(:merchant)
    @item_1, @item_2, @item_3, @item_4, @item_5 = create_list(:item, 5, user: @merchant)

    @order_1 = create(:completed_order, user: @user_1)
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2)

    @order_2 = create(:completed_order, user: @user_2)
    @order_item_3 = create(:fulfilled_order_item, order: @order_2, item: @item_2)
    @order_item_4 = create(:fulfilled_order_item, order: @order_2, item: @item_3)

    @order_3 = create(:cancelled_order, user: @user_1)
    @order_item_5 = create(:order_item, order: @order_3, item: @item_3)
    @order_item_6 = create(:order_item, order: @order_3, item: @item_4)

    @order_4 = create(:completed_order, user: @user_3)
    @order_item_7 = create(:order_item, order: @order_4, item: @item_1)
    @order_item_8 = create(:order_item, order: @order_4, item: @item_3)

    @rate_1 = create(:rating, user: @user_1, order_item: @order_item_1)
    @rate_2 = create(:rating, user: @user_1, order_item: @order_item_2)
    @rate_3 = create(:rating, user: @user_2, order_item: @order_item_3)
    @rate_4 = create(:rating, user: @user_2, order_item: @order_item_4)
    @rate_5 = create(:rating, user: @user_3, order_item: @order_item_7)
    @rate_6 = create(:rating, user: @user_3, order_item: @order_item_8)
  end

  it 'Goes to item show and see reviews and can find a disable button for review' do
    visit item_path(@item_1)

    expect(page).to have_content(@rate_5.title)
    expect(page).to have_content(@rate_1.title)
    expect(page).to have_content(@rate_1.description)
    expect(page).to have_content(@rate_5.description)

    expect(page).to_not have_content(@rate_2.title)
    expect(page).to_not have_content(@rate_3.title)
    expect(page).to_not have_content(@rate_4.title)
    expect(page).to_not have_content(@rate_6.title)

    click_on "Disable Review #{@rate_5.id}"

    expect(current_path).to eq(item_path(@item_1))

    click_on "Enable Review #{@rate_5.id}"

    expect(current_path).to eq(item_path(@item_1))
  end
end

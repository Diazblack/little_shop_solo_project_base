require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'Relationships' do
    it{is_expected.to belong_to(:order_item)}
    it{is_expected.to belong_to(:user)}
  end

  describe 'Validations' do
    it{is_expected.to validate_presence_of(:title)}
    it{is_expected.to validate_presence_of(:description)}
    it{is_expected.to validate_presence_of(:rate)}
    it{is_expected.to validate_numericality_of(:rate).is_greater_than_or_equal_to(1)}
    it{is_expected.to validate_numericality_of(:rate).is_less_than_or_equal_to(5)}
  end

end

class Rating < ApplicationRecord
  validates_presence_of :title, :description, :rate
  validates :rate, numericality: {greater_than_or_equal_to: 1 , less_than_or_equal_to: 5}
end

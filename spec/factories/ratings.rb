FactoryBot.define do
  factory :rating do
    user
    order_item
    sequence :title       { |n| "Title #{n}" }
    sequence :description { |n| "My text #{n}" }
    rate                  { 3 }
  end
end

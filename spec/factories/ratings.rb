FactoryBot.define do
  factory :rating do
    sequence :title       { |n| "Title #{n}" }
    sequence :description { "My text #{n}" }
    rate                  { 3 }
    users
    order_items
  end
end

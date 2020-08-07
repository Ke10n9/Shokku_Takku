FactoryBot.define do
  factory :dish do
    name { "MyString" }
    category { "MyString" }
    menu { nil }
  end

  factory :first_dish, class: Dish do
    name { "鮭" }
    category { "主食" }
    menu { nil }
  end
end

FactoryBot.define do
  factory :dish do
    name { "MyString" }
    category { "副菜" }
    menu { nil }
  end

  factory :first_dish, class: Dish do
    name { "鮭" }
    category { "主菜" }
    menu { nil }
  end

  factory :second_dish, class: Dish do
    name { "味噌汁" }
    category { "汁物" }
    menu { nil }
  end

  ["breakfast", "lunch", "dinner"].each do |time|
    5.times do |n|
      ["主菜", "副菜", "汁物"].each do |cat|
        factory :"#{time}-#{n}-#{cat}", class: Dish do
          name { "#{time}-#{n}-#{cat}" }
          category { cat }
        end
      end
    end
  end
end

FactoryBot.define do
  factory :menu do
    date { "2020-7-16" }
    time { "MyString" }
    user { nil }
  end

  factory :most_recent, class: Menu do
    date { Date.today }
    time { "MyString" }
    user { nil }
    updated_at { Time.zone.now }
  end

  factory :first_menu, class: Menu do
    date { Date.yesterday }
    time { "夕食" }
    user { nil }
  end

  31.times do |n|
    factory :"menu-#{n}", class: Menu do
      date { Date.today - n }
      time { "夕食" }
    end
  end
end

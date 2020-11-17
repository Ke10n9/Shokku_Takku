FactoryBot.define do
  factory :menu do
    date { "2020-7-16" }
    time { "夕食" }
    user { nil }
  end

  factory :most_recent, class: Menu do
    date { Date.today }
    time { "朝食" }
    user { nil }
    updated_at { Time.zone.now }
  end

  factory :first_menu, class: Menu do
    date { "2020-8-7" }
    time { "夕食" }
    user { nil }
  end

  factory :today_lunch, class: Menu do
    date { Date.today }
    time { "昼食" }
    user { nil }
  end

  (-8..30).each do |n|
    factory :"menu-#{n}", class: Menu do
      date { Date.today - n }
      time { "夕食" }
    end
  end

  5.times do |n|
    factory :"breakfast-#{n}", class: Menu do
      date { Date.today - 90 + n }
      time { "朝食" }
    end
  end

  5.times do |n|
    factory :"lunch-#{n}", class: Menu do
      date { Date.today - 90 + n }
      time { "昼食" }
    end
  end

  5.times do |n|
    factory :"dinner-#{n}", class: Menu do
      date { Date.today - 90 + n }
      time { "夕食" }
    end
  end
end

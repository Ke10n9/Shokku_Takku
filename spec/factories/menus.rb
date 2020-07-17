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
    created_at { Time.zone.now }
  end
end

FactoryBot.define do
  factory :michael, class: User do
    name { "Michael Example" }
    email { "michael@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :archer, class: User do
    name { "Aterling Archer" }
    email { "duchess@example.gov" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :lana, class: User do
    name { "Lana Kane" }
    email { "hands@example.gov" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :malory, class: User do
    name { "Malory Archer" }
    email { "boss@example.gov" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :test, class: User do
    name { "Test User" }
    email { "test@railstutorial.org" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :non_activate, class: User do
    name { "Non Activate" }
    email { "non_activate@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { false }
  end

  30.times do |n|
    factory :"user-#{n}", class: User do
      name { "User #{n}" }
      email { "user-#{n}@example.com" }
      password { "password" }
      password_confirmation { "password" }
      activated { true }
      activated_at { Time.zone.now }
    end
  end
end

FactoryBot.define do
  factory :michael, class: User do
    name { "Michael Example" }
    email { "michael@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end

  factory :archer, class: User do
    name { "Aterling Archer" }
    email { "duchess@example.gov" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :lana, class: User do
    name { "Lana Kane" }
    email { "hands@example.gov" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :malory, class: User do
    name { "Malory Archer" }
    email { "boss@example.gov" }
    password { "password" }
    password_confirmation { "password" }
  end

  30.times do |n|
    factory :"user-#{n}", class: User do
      name { "User #{n}" }
      email { "user-#{n}@example.com" }
      password { "password" }
      password_confirmation { "password" }
    end
  end
end

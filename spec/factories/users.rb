FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { :patron }

    trait :admin do
      role { :admin }
    end

    trait :librarian do
      role { :librarian }
    end
  end
end

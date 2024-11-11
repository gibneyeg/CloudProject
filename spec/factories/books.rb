FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    sequence(:isbn) { |n| "ISBN-#{n}-#{rand(10000)}" }
    sequence(:author) { |n| "Author #{n}" }
    description { "Description" }
    available { true }
    association :category
  end
end
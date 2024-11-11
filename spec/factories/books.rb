FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    sequence(:isbn) { |n| "ISBN-#{n}-#{rand(10_000)}" }
    sequence(:author) { |n| "Author #{n}" }
    description { 'Description' }
    available { true }
    category
  end
end

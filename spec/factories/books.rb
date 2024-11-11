FactoryBot.define do
  factory :book do
    title { 'Sample Book' }
    sequence(:isbn) { |n| "ISBN-#{n}" }
    author { 'John Doe' }
    description { 'A great book about programming' }
    available { true }
    association :category
  end
end
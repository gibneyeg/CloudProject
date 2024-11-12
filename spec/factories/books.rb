FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book Title #{n}" }
    sequence(:isbn) { |n| "ISBN-#{n}-#{rand(10_000)}" }
    author { 'Author Name' }
    description { 'Book description' }
    available { true }
    category
  end
end

FactoryBot.define do
  factory :borrowing do
    user { nil }
    book { nil }
    due_date { "2024-11-11" }
    returned_date { "2024-11-11" }
  end
end

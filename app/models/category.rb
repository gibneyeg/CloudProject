class Category < ApplicationRecord
  has_many :books
  validates :name, presence: true, uniqueness: true
end

# app/models/borrowing.rb
class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :due_date, presence: true
  validate :book_must_be_available, on: :create
  
  private
  
  def book_must_be_available
    errors.add(:book, 'is not available') unless book.available?
  end
end
class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true
  validate :book_must_be_available, on: :create

  private

  def book_must_be_available
    return unless book&.respond_to?(:available?)
    errors.add(:book, 'is not available') unless book.available?
  end
end
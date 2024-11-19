class Category < ApplicationRecord
  # Associations
  has_many :books, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true

  # Instance methods
  def available_books
    books.where(available: true)
  end

  def borrowed_books
    books.where(available: false)
  end

  def total_books
    books.count
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at]
  end
end

class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :borrowings
  has_many :books, through: :borrowings

  # Enums
  enum :role, { patron: 0, librarian: 1, admin: 2 }, default: :patron
end

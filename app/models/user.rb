class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :borrowings
  has_many :books, through: :borrowings

  # Enums
  enum :role, [:patron, :librarian, :admin], default: :patron
end
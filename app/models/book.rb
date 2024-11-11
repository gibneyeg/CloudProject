class Book < ApplicationRecord
  belongs_to :category
  has_many :borrowings
  has_many :users, through: :borrowings
  
  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :author, presence: true
  
  scope :available, -> { where(available: true) }
  scope :borrowed, -> { where(available: false) }
end
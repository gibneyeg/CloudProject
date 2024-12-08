class Book < ApplicationRecord
  belongs_to :category
  has_many :borrowings, dependent: :destroy
  has_many :users, through: :borrowings

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :author, presence: true

  scope :available, -> { where(available: true) }
  scope :borrowed, -> { where(available: false) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title author category_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['category']
  end
end

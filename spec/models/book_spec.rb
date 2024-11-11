# spec/models/book_spec.rb
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do  # Changed from 'validations' to 'associations'
    subject { build(:book) }
    
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:borrowings) }
    it { is_expected.to have_many(:users).through(:borrowings) }
  end

  describe 'validations' do
    # Create a category first since book requires it
    let(:category) { create(:category) }
    # Build book with category for uniqueness validation
    subject { build(:book, category: category) }
    
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_presence_of(:author) }
    
    describe 'isbn uniqueness' do
      # Create a book first for uniqueness validation
      before { create(:book, category: category) }
      it { is_expected.to validate_uniqueness_of(:isbn) }
    end
  end

  # Add some additional test cases
  describe 'scopes and methods' do
    let(:category) { create(:category) }
    
    describe '.available' do
      let!(:available_book) { create(:book, category: category, available: true) }
      let!(:borrowed_book) { create(:book, category: category, available: false) }

      it 'returns only available books' do
        expect(Book.available).to include(available_book)
        expect(Book.available).not_to include(borrowed_book)
      end
    end

    describe '.borrowed' do
      let!(:available_book) { create(:book, category: category, available: true) }
      let!(:borrowed_book) { create(:book, category: category, available: false) }

      it 'returns only borrowed books' do
        expect(Book.borrowed).to include(borrowed_book)
        expect(Book.borrowed).not_to include(available_book)
      end
    end
  end
end
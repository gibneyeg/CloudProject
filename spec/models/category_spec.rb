require 'rails_helper'

RSpec.describe Category do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:books) }
  end

  describe 'instance methods' do
    let(:category) { create(:category) }
    let!(:available_book) { create(:book, category: category, available: true) }
    let!(:borrowed_book) { create(:book, category: category, available: false) }

    describe '#available_books' do
      it 'returns only available books in the category' do
        expect(category.available_books).to include(available_book)
        expect(category.available_books).not_to include(borrowed_book)
      end
    end

    describe '#borrowed_books' do
      it 'returns only borrowed books in the category' do
        expect(category.borrowed_books).to include(borrowed_book)
        expect(category.borrowed_books).not_to include(available_book)
      end
    end

    describe '#total_books' do
      it 'returns the total number of books in the category' do
        expect(category.total_books).to eq(2)
      end
    end
  end
end

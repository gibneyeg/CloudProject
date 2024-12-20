require 'rails_helper'

RSpec.describe Book do
  describe 'associations' do
    subject { build(:book) }

    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:borrowings) }
    it { is_expected.to have_many(:users).through(:borrowings) }
  end

  describe 'validations' do
    subject { build(:book, category: category) }

    let(:category) { create(:category) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_presence_of(:author) }

    describe 'isbn uniqueness' do
      before { create(:book, category: category) }

      it { is_expected.to validate_uniqueness_of(:isbn) }
    end
  end

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

  #tests for ransack
  describe 'searching' do
    describe '.ransackable_attributes' do
      it 'returns the allowed attributes for searching' do
        expect(Book.ransackable_attributes).to match_array(%w[title author category_id])
      end

      it 'does not include other attributes' do
        expect(Book.ransackable_attributes).not_to include('created_at', 'updated_at', 'isbn')
      end
    end

    describe '.ransackable_associations' do
      it 'returns the allowed associations for searching' do
        expect(Book.ransackable_associations).to contain_exactly('category')
      end

      it 'does not include other associations' do
        expect(Book.ransackable_associations).not_to include('borrowings', 'users')
      end
    end

    #tests for ransack
    describe 'search functionality' do
      let(:category) { create(:category, name: 'Fiction') }
      let(:ruby_book) { create(:book, title: 'Ruby Programming', author: 'John Doe', category: category) }
      let(:python_book) { create(:book, title: 'Python Basics', author: 'Jane Smith', category: category) }

      # creating book before using
      before do
        ruby_book
        python_book
      end

      it 'searches by title' do
        results = Book.ransack(title_cont: 'Ruby').result
        expect(results).to include(ruby_book)
        expect(results).not_to include(python_book)
      end

      it 'searches by author' do
        results = Book.ransack(author_cont: 'Smith').result
        expect(results).to include(python_book)
        expect(results).not_to include(ruby_book)
      end

      it 'searches by category' do
        results = Book.ransack(category_id_eq: category.id).result
        expect(results).to include(ruby_book, python_book)
      end

      it 'combines multiple search criteria' do
        results = Book.ransack(
          title_cont: 'Ruby',
          author_cont: 'Doe',
          category_id_eq: category.id
        ).result


        expect(results).to include(ruby_book)
        expect(results).not_to include(python_book)
      end
    end
  end
end

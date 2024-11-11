RSpec.describe Borrowing do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'validations and callbacks' do
    subject { build(:borrowing) }

    it { is_expected.to validate_presence_of(:due_date) }
  end

  describe 'book availability' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    it 'is valid when book is available' do
      borrowing = build(:borrowing, user: user, book: book)
      expect(borrowing).to be_valid
    end

    it 'is not valid when book is unavailable' do
      unavailable_book = create(:book, available: false)
      borrowing = build(:borrowing, user: user, book: unavailable_book)

      expect(borrowing).not_to be_valid
      expect(borrowing.errors[:book]).to include('is not available')
    end
  end
end

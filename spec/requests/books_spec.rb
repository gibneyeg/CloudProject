require 'rails_helper'

RSpec.describe 'Books' do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, category: category) }

  before do
    login_as(user, scope: :user)
  end

  after do
    Warden.test_reset!
  end

  describe 'GET actions' do
    it 'shows the index page' do
      get books_path
      expect(response).to have_http_status(:success)
    end

    it 'shows a book' do
      get book_path(book)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end

    it 'shows the new book form' do
      get new_book_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST actions' do
    let(:valid_attributes) { attributes_for(:book, category_id: category.id) }

    context 'with valid parameters' do
      it 'creates a new book' do
        expect {
          post books_path, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
        expect(response).to redirect_to(book_path(Book.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new book' do
        expect {
          post books_path, params: { book: { title: '' } }
        }.not_to change(Book, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT actions' do
    let(:new_attributes) { { title: 'Updated Title' } }

    context 'with valid parameters' do
      it 'updates the book' do
        put book_path(book), params: { book: new_attributes }
        book.reload
        expect(book.title).to eq('Updated Title')
        expect(response).to redirect_to(book_path(book))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the book' do
        put book_path(book), params: { book: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE actions' do
    it 'deletes the book' do
      book_to_delete = create(:book, category: category)
      expect {
        delete book_path(book_to_delete)
      }.to change(Book, :count).by(-1)
      expect(response).to redirect_to(books_path)
    end
  end

  describe 'search and filter' do
    it 'filters books by title' do
      create(:book, title: 'Ruby Programming', category: category)
      create(:book, title: 'Python Basics', category: category)

      get books_path, params: { q: { title_cont: 'Ruby' } }
      expect(response.body).to include('Ruby Programming')
      expect(response.body).not_to include('Python Basics')
    end
  end

  describe 'error handling' do
    it 'handles record not found' do
      get book_path(0)
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to(books_path)
    end
  end
end

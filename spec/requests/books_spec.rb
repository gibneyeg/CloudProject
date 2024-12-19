require 'rails_helper'

RSpec.describe 'Books' do
  let(:user) { create(:user) }
  let(:admin) { create(:user, email: 'admin@library.com') }
  let(:category) { create(:category) }
  let(:book) { create(:book, category: category) }

  describe 'as regular user' do
    before { login_as(user, scope: :user) }
    after { Warden.test_reset! }

    it 'shows a book' do
      Rails.application.load_seed
      get book_path(book)
      expect(response).to have_http_status(:success)
    end

    it 'does not show new book button in index' do
      get books_path
      expect(response).to have_http_status(:success)
      expect(response.body).not_to include('Add New Book')
    end

  end

  describe 'as admin' do
    before { login_as(admin, scope: :user) }
    after { Warden.test_reset! }

    describe 'book management' do
      it 'updates the book with valid parameters' do
        put book_path(book), params: { book: { title: 'Updated Title' } }
        book.reload
        expect(book.title).to eq('Updated Title')
        expect(response).to redirect_to(book_path(book))
      end

      it 'fails to update with invalid parameters' do
        put book_path(book), params: { book: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'creates a new book with valid parameters' do
        valid_attributes = attributes_for(:book, category_id: category.id)
        expect {
          post books_path, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
        expect(response).to redirect_to(book_path(Book.last))
      end

      it 'fails to create with invalid parameters' do
        expect {
          post books_path, params: { book: { title: '' } }
        }.not_to change(Book, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'deletes the book' do
        book_to_delete = create(:book, category: category)
        expect {
          delete book_path(book_to_delete)
        }.to change(Book, :count).by(-1)
        expect(response).to redirect_to(books_path)
      end
    end
  end

  describe 'public features' do
    it 'filters books by title' do
      create(:book, title: 'Ruby Programming', category: category)
      create(:book, title: 'Python Basics', category: category)
      get books_path, params: { q: { title_cont: 'Ruby' } }
      expect(response.body).to include('Ruby Programming')
      expect(response.body).not_to include('Python Basics')
    end

    it 'handles record not found' do
      login_as(user, scope: :user)
      get book_path(0)
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to(books_path)
    end
  end
end

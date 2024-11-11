require 'rails_helper'

RSpec.describe "Borrowings", type: :request do
  describe "as an authenticated user" do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:book) { create(:book, category: category) }
    let(:borrowing) { create(:borrowing, user: user, book: book) }

    before do
      # Make sure objects are created before signing in
      category
      book
      borrowing
      sign_in user
    end

    it "shows the index page" do
      get borrowings_path
      expect(response).to have_http_status(:success)
    end

    it "shows a borrowing" do
      get borrowing_path(borrowing)
      expect(response).to have_http_status(:success)
    end

    it "shows the new borrowing form" do
      get new_borrowing_path
      expect(response).to have_http_status(:success)
    end
  end
end
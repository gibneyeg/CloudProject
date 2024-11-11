require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "as an authenticated user" do
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    before do
      # Make sure category is created before signing in
      category
      sign_in user
    end

    it "shows the index page" do
      get categories_path
      expect(response).to have_http_status(:success)
    end

    it "shows a category" do
      get category_path(category)
      expect(response).to have_http_status(:success)
    end

    it "shows the new category form" do
      get new_category_path
      expect(response).to have_http_status(:success)
    end

    it "shows the edit category form" do
      get edit_category_path(category)
      expect(response).to have_http_status(:success)
    end
  end
end
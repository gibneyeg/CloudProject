require 'rails_helper'

RSpec.describe 'Categories' do
  describe 'as an authenticated user' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    before do
      # Make sure category is created before signing in
      category
      sign_in user
    end

    it 'shows the index page' do
      get categories_path
      expect(response).to have_http_status(:success)
    end

  end
end

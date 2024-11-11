require 'rails_helper'

RSpec.describe "Borrowings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/borrowings/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/borrowings/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/borrowings/new"
      expect(response).to have_http_status(:success)
    end
  end

end

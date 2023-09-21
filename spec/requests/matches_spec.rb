require 'rails_helper'

RSpec.describe "Matches", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/matches/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/matches/create"
      expect(response).to have_http_status(:success)
    end
  end

end

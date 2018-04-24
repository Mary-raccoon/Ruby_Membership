require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  describe "GET #main" do
    it "returns http success" do
      get :main
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
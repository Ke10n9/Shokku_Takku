require 'rails_helper'

RSpec.describe "StaticPages", type: :request do


let(:base_title) { 'Shokku Takku' }

  describe "Home" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
      assert_select "title", "Home | #{base_title}"
    end
  end

end

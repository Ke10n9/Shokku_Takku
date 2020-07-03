require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  # render_views
  let(:base_title) { 'Shokku Takku' }

    describe "Home" do
      before { get root_path }
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "has title 'Shokku Takku'" do
        expect(response.body).to match(/<title>#{base_title}<\/title>/i)
      end
    end

end

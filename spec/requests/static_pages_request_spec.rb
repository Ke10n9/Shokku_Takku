require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  # render_views
  let(:base_title) { 'ダテさん -献立記録サービス-' }

    describe "Home" do
      before { get root_path }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "has title 'ダテさん -献立記録サービス-'" do
        expect(response.body).to match(/<title>#{base_title}<\/title>/i)
      end
    end

end

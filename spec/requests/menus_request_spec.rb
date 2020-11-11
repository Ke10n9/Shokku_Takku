require 'rails_helper'

RSpec.describe "Menus", type: :request do
  before {
    @user = create(:michael)
    @other_user = create(:archer)
    @menu = create(:menu, user: @user)
  }

  let(:menu_params) {
    { date: Date.today,
      time: "夕食",
      picture: "test_picture"}
  }

  describe "POST /create" do
    context "without login user" do
      it "don't create menu" do
        expect do
          post menus_path, params: { menu: menu_params }
        end.to change(Menu, :count).by(0)
      end

      it "redirect to login_url" do
        post menus_path, params: { menu: menu_params }
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "DELETE /destroy" do
    context "without login user" do
      it "don't destroy menu" do
        expect do
          delete menu_path(@menu)
        end.to change(Menu, :count).by(0)
      end

      it "redirect to login_url" do
        delete menu_path(@menu)
        expect(response).to redirect_to login_url
      end
    end

    context "with wrong login user" do
      before { log_in_path @other_user }

      it "don't destroy menu" do
        expect do
          delete menu_path(@menu)
        end.to change(Menu, :count).by(0)
      end

      it "redirect to root_url" do
        delete menu_path(@menu)
        expect(response).to redirect_to root_url
      end
    end
  end
end

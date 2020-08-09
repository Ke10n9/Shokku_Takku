require 'rails_helper'

RSpec.describe "Menus", type: :request do
  before {
    @user = create(:michael)
    @other_user = create(:archer)
    @menu = create(:menu, user: @user)
  }

  let(:menu_params) {
    { name: "豚肉",
      category: "主菜" }
  }

  describe "POST /create" do
    context "when not logged in" do
      it "not create menu" do
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
    context "when not logged in" do
      it "not destroy menu" do
        expect do
          delete menu_path(@menu)
        end.to change(Menu, :count).by(0)
      end

      it "redirect to login_url" do
        delete menu_path(@menu)
        expect(response).to redirect_to login_url
      end
    end

    context "when the user is wrong" do
      before { log_in_path @other_user }

      it "not destroy menu" do
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

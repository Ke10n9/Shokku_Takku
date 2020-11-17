require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  background {
    @other_user = create(:archer)
    visit root_path
    click_link "ユーザー登録"
  }

  context "with invalid values" do
    background {
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      fill_in "パスワード（再確認）", with: ""
    }

    scenario "don't let an user sign up" do
      expect do
        click_button "登録"
      end.to change(User, :count).by(0)
    end

    scenario "show error_explanation" do
      click_button "登録"
      expect(page).to have_selector("#error_explanation")
    end

    scenario "show alert_danger" do
      click_button "登録"
      expect(page).to have_selector(".alert-danger", text: "入力した内容に4つのエラーがあります。")
    end

    scenario "show alert_danger" do
      click_button "登録"
      expect(page).to have_current_path('/users')
    end
  end

  context "with duplicate email" do
    background {
      fill_in "ユーザー名", with: "Example User"
      fill_in "メールアドレス", with: @other_user.email
      fill_in "パスワード", with: "password"
      fill_in "パスワード（再確認）", with: "password"
    }

    scenario "don't let an user sign up" do
      expect do
        click_button "登録"
      end.to change(User, :count).by(0)
    end

    scenario "show error_explanation" do
      click_button "登録"
      expect(page).to have_selector("#error_explanation")
    end

    scenario "show alert_danger" do
      click_button "登録"
      expect(page).to have_selector(".alert-danger", text: "入力した内容に1つのエラーがあります。")
    end

    scenario "show alert_danger" do
      click_button "登録"
      expect(page).to have_current_path('/users')
    end
  end

  # 有効な値が入力されたとき
  context "with valid values" do
    background {
      fill_in "ユーザー名", with: "Example User"
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（再確認）", with: "password"
    }

    scenario "add an user" do
      expect do
        click_button "登録"
      end.to change(User, :count).by(1)
    end

    scenario "redirect_to root_path" do
      click_button "登録"
      expect(page).to have_current_path(root_path)
    end


    # scenario "get a flash message 'Shokku Takkuへようこそ！'" do
    #   expect(page).to have_selector(".alert-success",
    #                                 text: "Shokku Takkuへようこそ！")
    # end

    # scenario "render to '/users/1'" do
    #   expect(page).to have_current_path "/users/1"
    # end
  end
end

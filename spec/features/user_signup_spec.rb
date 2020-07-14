require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  # 無効な値が入力されたとき
  context "entered invalid values" do
    background {
      visit signup_path
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      fill_in "パスワード（再確認）", with: ""
      click_button "登録"
    }

    scenario "get error messages" do
      expect(page).to have_selector("#error_explanation")
    end

    scenario "get error messages '入力した内容に4つのエラーがあります。'" do
      expect(page).to have_selector(".alert-danger",
                                    text: "入力した内容に4つのエラーがあります。")
    end

    scenario "render to '/users'" do
      expect(page).to have_current_path "/users"
    end
  end

  # 有効な値が入力されたとき
  context "entered valid values" do
    before do
      visit signup_path
      fill_in "ユーザー名", with: "Example User"
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（再確認）", with: "password"
      click_button "登録"
    end

    scenario "get a flash message 'Shokku Takkuへようこそ！'" do
      expect(page).to have_selector(".alert-success",
                                    text: "Shokku Takkuへようこそ！")
    end

    scenario "render to '/users/1'" do
      expect(page).to have_current_path "/users/1"
    end
  end
end

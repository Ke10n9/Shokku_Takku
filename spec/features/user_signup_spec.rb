require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  # 無効な値が入力されたとき
  scenario "are entered invalid values" do
    visit signup_path
    fill_in "ユーザー名", with: ""
    fill_in "メールアドレス", with: ""
    fill_in "パスワード", with: ""
    fill_in "パスワード（再確認）", with: ""
    click_button "登録"
    expect(page).to have_selector("#error_explanation")
    expect(page).to have_selector(".alert-danger",
                                  text: "入力した内容に6つのエラーがあります。")
    expect(page).to have_content("パスワードを入力してください", count: 2)
    expect(page).to have_current_path "/signup"
  end
  # 有効な値が入力されたとき
  scenario "are entered valid values" do
    visit signup_path
    fill_in "ユーザー名", with: "Example User"
    fill_in "メールアドレス", with: "user@example.com"
    fill_in "パスワード", with: "password"
    fill_in "パスワード（再確認）", with: "password"
    click_button "登録"
    expect(page).to have_selector(".alert-success",
                                  text: "Shokku Takkuへようこそ！")
    expect(page).to have_current_path "/users/1"
  end
end

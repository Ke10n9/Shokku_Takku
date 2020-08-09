require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  background {
    @user = create(:michael)
  }

  scenario "can not edit with an invalid value" do
    log_in_as @user
    visit edit_user_path(@user)
    fill_in "ユーザー名", with: ""
    fill_in "メールアドレス", with: "foo@invalid"
    fill_in "パスワード", with: "foo"
    fill_in "パスワード（再確認）", with: "bar"
    click_button "保存"
    expect(page).to have_selector("#error_explanation")
    expect(page).to have_selector(".alert-danger",
                                  text: "入力した内容に4つのエラーがあります。")
  end

  scenario "can edit with a valid value" do
    # フレンドリーフォワーディングのテスト
    visit edit_user_path(@user)
    log_in_as @user
    expect(page).to have_current_path edit_user_url(@user)

    name = "Foo Bar"
    email = "foo@bar.com"
    fill_in "ユーザー名", with: name
    fill_in "メールアドレス", with: email
    click_button "保存"
    expect(page).to have_selector(".alert-success")
    expect(page).to have_current_path "/users/#{@user.id}"
    @user.reload
    expect(@user.name).to eq(name)
    expect(@user.email).to eq(email)
  end
end

require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  background {
    @user = create(:michael)
    log_in_as @user
  }

  context "entered invalid values" do
    background {
      visit edit_user_path(@user)
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: "foo@invalid"
      fill_in "パスワード", with: "foo"
      fill_in "パスワード（再確認）", with: "bar"
      click_button "保存"
    }

    scenario "get error messages" do
      expect(page).to have_selector("#error_explanation")
    end

    scenario "get error messages '入力した内容に4つのエラーがあります。'" do
      expect(page).to have_selector(".alert-danger",
                                    text: "入力した内容に4つのエラーがあります。")
    end
  end
end

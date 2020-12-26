require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  background {
    @user = create(:archer)
    @other_user = create(:michael)
    @default_name = @user.name
    @default_email = @user.email
    @default_password = @user.password
    @update_name = "update_name"
    @update_email = "update_email@example.com"
    @update_password = "update_password"
  }

  context "with login user" do
    background {
      log_in_as @user
      visit root_path
      click_link href: edit_user_path(@user)
    }

    scenario "redirect_to edit_user_path(@user)" do
      expect(page).to have_current_path(edit_user_path(@user))
    end

    context "filled in invalid name" do
      background {
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: @update_email
        fill_in "パスワード", with: @update_password
        fill_in "パスワード（再確認）", with: @update_password
        click_button "保存"
        @user.reload
      }

      scenario "don't update @user.name" do
        expect(@user.name).to eq(@default_name)
      end

      scenario "don't update @user.email" do
        expect(@user.email).to eq(@default_email)
      end

      scenario "don't update @user.password" do
        expect(@user.password).to eq(@default_password)
      end

      scenario "show selector '#error_explanation'" do
        expect(page).to have_selector("#error_explanation")
      end
    end

    context "filled in invalid email" do
      background {
        fill_in "ユーザー名", with: @update_name
        fill_in "メールアドレス", with: "invalid_email"
        fill_in "パスワード", with: @update_password
        fill_in "パスワード（再確認）", with: @update_password
        click_button "保存"
        @user.reload
      }

      scenario "don't update @user.name" do
        expect(@user.name).to eq(@default_name)
      end

      scenario "don't update @user.email" do
        expect(@user.email).to eq(@default_email)
      end

      scenario "don't update @user.password" do
        expect(@user.password).to eq(@default_password)
      end

      scenario "show selector '#error_explanation'" do
        expect(page).to have_selector("#error_explanation")
      end
    end

    context "filled in duplicate email" do
      background {
        fill_in "ユーザー名", with: @update_name
        fill_in "メールアドレス", with: @other_user.email
        fill_in "パスワード", with: @update_password
        fill_in "パスワード（再確認）", with: @update_password
        click_button "保存"
        @user.reload
      }

      scenario "don't update @user.name" do
        expect(@user.name).to eq(@default_name)
      end

      scenario "don't update @user.email" do
        expect(@user.email).to eq(@default_email)
      end

      scenario "don't update @user.password" do
        expect(@user.password).to eq(@default_password)
      end

      scenario "show selector '#error_explanation'" do
        expect(page).to have_selector("#error_explanation")
      end
    end

    context "filled in invalid password" do
      background {
        fill_in "ユーザー名", with: @update_name
        fill_in "メールアドレス", with: @update_email
        fill_in "パスワード", with: "no"
        fill_in "パスワード（再確認）", with: "no"
        click_button "保存"
        @user.reload
      }

      scenario "don't update @user.name" do
        expect(@user.name).to eq(@default_name)
      end

      scenario "don't update @user.email" do
        expect(@user.email).to eq(@default_email)
      end

      scenario "don't update @user.password" do
        expect(@user.password).to eq(@default_password)
      end

      scenario "show selector '#error_explanation'" do
        expect(page).to have_selector("#error_explanation")
      end
    end

    context "filled in valid name and email" do
      background {
        fill_in "ユーザー名", with: @update_name
        fill_in "メールアドレス", with: @update_email
        click_button "保存"
        @user.reload
      }

      scenario "redirect_to root_path" do
        expect(page).to have_current_path(root_path)
      end

      scenario "update @user.name" do
        expect(@user.name).to eq(@update_name)
      end

      scenario "update @user.email" do
        expect(@user.email).to eq(@update_email)
      end

      scenario "don't update @user.password" do
        expect(@user.password).to eq(@default_password)
      end

      scenario "show selector '.alert-success'" do
        expect(page).to have_selector(".alert-success")
      end
    end

    context "clicked delete user link", js: true do
      background {
        page.accept_confirm do
          click_link "こちら"
        end
        sleep 0.5
      }

      scenario "delete current_user and redirect_to root_path" do
        expect(User.find_by(name: @default_name)).to be_falsey
        expect(page).to have_current_path(root_path)
      end
    end

    # context "uploaded valid image file" do
    #   background {
    #     attach_file "画像", "./spec/fixtures/files/test.png"
    #   }
    #
    #   scenario "redirect_to root_path" do
    #     expect(page).to have_current_path(root_path)
    #   end
    # end

    # context "filled in valid password" do
    #   background {
    #     fill_in "パスワード", with: @update_password
    #     fill_in "パスワード（再確認）", with: @update_password
    #     click_button "保存"
    #     @user.reload
    #   }
    #
    #   scenario "redirect_to root_path" do
    #     expect(page).to have_current_path(root_path)
    #   end
    #
    #   scenario "update @user.password" do
    #     expect(@user.password).to eq(@update_password)
    #   end
    #
    #   scenario "show selector '.alert-success'" do
    #     expect(page).to have_selector(".alert-success")
    #   end
    # end
  end
end

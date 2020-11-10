require 'rails_helper'

RSpec.feature "PageLayouts", type: :feature do

  feature "root_path" do
    background {
      visit root_path
      @user = create(:michael)
      @test = create(:test)
    }

    context "with no user logged in" do

      scenario "have_link signup_path" do
        expect(page).to have_link(href: signup_path)
      end

      context "click_link 'テストログイン'" do
        background {
          click_button "テストログイン"
        }

        scenario "and redirect_to root_path" do
          expect(page).to have_current_path root_path
        end

        scenario "login Test User" do
          expect(page).to have_css("div", text: @test.name)
        end
      end

      scenario "don't have home-grid)" do
        expect(page).not_to have_css("div.home-grid")
      end
    end

    context "with the user logged in" do
      background {
        log_in_as @user
      }

      scenario "don't have_link signup_path" do
        expect(page).not_to have_link(signup_path)
      end

      scenario "don't have_button 'テストユーザー'" do
        expect(page).not_to have_button "テストユーザー"
      end

      scenario "have_link user_path(@user)" do
        expect(page).to have_link( href: user_path(@user) )
      end

      scenario "have_link menus_path" do
        expect(page).to have_link( href: menus_path )
      end

      scenario "have_link recommend_path" do
        expect(page).to have_link( href: recommend_path )
      end

      scenario "have_link new_menu_path" do
        expect(page).to have_link( href: new_menu_path )
      end

      scenario "have_link edit_user_path(@user)" do
        expect(page).to have_link( href: edit_user_path(@user) )
      end
    end
  end

  feature "header" do
    background { visit root_path }

    scenario "have_link 'ダテさん' href: root_path" do
      expect(page).to have_link("ダテさん", href: root_path)
    end

    context "when an user is not yet logged in" do

      scenario "have_link 'ログイン' href: login_path" do
        expect(page).to have_link("ログイン", href: login_path)
      end

      scenario "have_css '献立記録サービス'" do
        expect(page).to have_css(".sub-title", text: "献立記録サービス")
      end

      scenario "don't have_link 'ホーム' href: root_path" do
        expect(page).not_to have_link("ホーム", href: root_path)
      end

      scenario "don't have_link 'ログアウト' href: logout_path" do
        expect(page).not_to have_link("ログアウト", href: logout_path)
      end
    end

    context "when an user is already logged in" do
      background {
        @user = create(:michael)
        log_in_as @user
      }

      scenario "don't have_link 'ログイン' href: login_path" do
        expect(page).not_to have_link("ログイン", href: login_path)
      end

      scenario "don't have_css '-献立記録サービス-'" do
        expect(page).not_to have_css(".sub-title", text: "-献立記録サービス-")
      end

      scenario "have_css 'for [ユーザー名]'" do
        expect(page).to have_css(".sub-title", text: "for #{@user.name}")
      end

      scenario "have_link 'ホーム' href: root_path" do
        expect(page).to have_link("ホーム", href: root_path)
      end

      scenario "have_link 'ログアウト' href: logout_path" do
        expect(page).to have_link("ログアウト", href: logout_path)
      end
    end
  end

  feature "everyone's menu" do
    background {
      @user = create(:michael)
      @other_user = create(:archer)
      @menu_31th_newest = create(:"menu-0", user: @other_user)
      @menu_30th_newest = create(:"menu-1", user: @other_user)
      (2..29).each do |n|
        create(:"menu-#{n}", user: @other_user)
      end
      @newest_menu = create(:"menu-30", picture: "test_picture", user: @user)
      @dish = create(:dish, menu: @newest_menu)
    }

    context "in root_path" do
      background { visit root_path }

      scenario "have_css 'みんなの献立'" do
        expect(page).to have_css("h2", text: "みんなの献立")
      end

      scenario "have_css horizontal-list" do
        expect(page).to have_css(".horizontal-list")
      end

      scenario "have the newest menu" do
        expect(page).to have_content("#{@newest_menu.date} #{@newest_menu.time}")
      end

      scenario "have 30th newest menu" do
        expect(page).to have_content("#{@menu_30th_newest.date} #{@menu_30th_newest.time}")
      end

      scenario "don't have 31th newest menu" do
        expect(page).not_to have_content("#{@menu_31th_newest.date} #{@menu_31th_newest.time}")
      end

      scenario "have menu's user" do
        expect(page).to have_content("#{@newest_menu.user.name}")
      end

      scenario "have menu's picture" do
        expect(page).to have_content("#{@newest_menu.picture}")
      end

      scenario "have menu's dish name" do
        expect(page).to have_content("#{@dish.name}")
      end
    end

    context "in menus_path" do
      background { visit menus_path }

      scenario "have_css vertical-list" do
        expect(page).to have_css(".vertical-list")
      end

      scenario "have the newest menu" do
        expect(page).to have_content("#{@newest_menu.date} #{@newest_menu.time}")
      end

      scenario "have 30th newest menu" do
        expect(page).to have_content("#{@menu_30th_newest.date} #{@menu_30th_newest.time}")
      end

      scenario "don't have 31th newest menu" do
        expect(page).not_to have_content("#{@menu_31th_newest.date} #{@menu_31th_newest.time}")
      end

      scenario "have menu's user" do
        expect(page).to have_content("#{@newest_menu.user.name}")
      end

      scenario "have menu's picture" do
        expect(page).to have_content("#{@newest_menu.picture}")
      end

      scenario "have menu's dish name" do
        expect(page).to have_content("#{@dish.name}")
      end
    end
  end
end

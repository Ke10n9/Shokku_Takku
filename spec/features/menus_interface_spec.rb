require 'rails_helper'

RSpec.feature "MenusInterfaces", type: :feature do
  background {
    @user = create(:michael)
    @other_user = create(:archer)
  }

  feature "Form" do
    context "without logged-in user" do

      scenario "is not displayed in root_url" do
        visit root_url
        expect(page).not_to have_selector "form"
      end
    end

    context "with logged-in user" do
      background {
        log_in_as @user
        visit root_url
      }

      scenario "is displayed in root_url" do
        expect(page).to have_selector "form"
      end

      scenario "is entered today's date in the date form" do
        expect(page).to have_field "menu_date", with: Time.now.strftime("%Y-%m-%d")
      end

      scenario "is not selected in the time form" do
        expect(page).to have_select "menu_time", selected: []
      end

      scenario "is not selected in the dish_category form" do
        expect(page).to have_select "dish_category", selected: []
      end
    end
  end

  feature "Registeration" do
    context "with logged-in user" do
      background {
        log_in_as @user
      }

      context "and invalid menu" do
        background {
          @menu_date = ""
          @menu_time = "夕食"
          @dish_category = "主菜"
          @dish_name = "鮭"
          visit root_url
          fill_in "menu_date", with: @menu_date
          select @menu_time, from: "menu_time"
          select @dish_category, from: "dish_category"
          fill_in "dish_name", with: @dish_name
          click_button "送信"
        }

        scenario "render root_url" do
          expect(page).to have_current_path "/menus"
        end

        scenario "display danger message" do
          expect(page).to have_selector(".alert-danger")
        end

        scenario "enter the same date in the form as last time" do
          expect(page).to have_field "menu_date", with: @menu_date
        end

        scenario "enter the same time in the form as last time" do
          expect(page).to have_select "menu_time", selected: @menu_time
        end

        scenario "enter the same dish_category in the form as last time" do
          expect(page).to have_select "dish_category", selected: @dish_category
        end

        scenario "enter the same dish_name in the form as last time" do
          expect(page).to have_field "dish_name", with: @dish_name
        end

        scenario "is accepted normally if content is fixed after invalid register" do
          @menu_date = Date.yesterday
          fill_in "menu_date", with: @menu_date
          click_button "送信"
          expect(page).to have_selector(".alert-success")
        end
      end

      context "and invalid dish" do
        background {
          @menu_date = Date.yesterday
          @menu_time = "夕食"
          @dish_category = "主菜"
          @dish_name = "a" * 31
          visit root_url
          fill_in "menu_date", with: @menu_date
          select @menu_time, from: "menu_time"
          select @dish_category, from: "dish_category"
          fill_in "dish_name", with: @dish_name
          click_button "送信"
        }

        scenario "render root_url" do
          expect(page).to have_current_path "/menus"
        end

        scenario "display danger message" do
          expect(page).to have_selector(".alert-danger")
        end

        scenario "enter the same date in the form as last time" do
          expect(page).to have_field "menu_date", with: @menu_date
        end

        scenario "enter the same time in the form as last time" do
          expect(page).to have_select "menu_time", selected: @menu_time
        end

        scenario "enter the same dish_category in the form as last time" do
          expect(page).to have_select "dish_category", selected: @dish_category
        end

        scenario "enter the same dish_name in the form as last time" do
          expect(page).to have_field "dish_name", with: @dish_name
        end

        scenario "is accepted normally if content is fixed after invalid register" do
          @dish_name = "鮭"
          fill_in "dish_name", with: @dish_name
          click_button "送信"
          expect(page).to have_selector(".alert-success")
        end
      end

      context "and new menu" do
        background {
          @menu_date = Date.yesterday
          @menu_time = "夕食"
          @dish_category = "主菜"
          @dish_name = "鮭"
          visit root_url
          fill_in "menu_date", with: @menu_date
          select @menu_time, from: "menu_time"
          select @dish_category, from: "dish_category"
          fill_in "dish_name", with: @dish_name
        }

        scenario "add a menu" do
          expect do
            click_button "送信"
          end.to change(Menu, :count).by(1)
        end

        scenario "add a dish" do
          expect do
            click_button "送信"
          end.to change(Dish, :count).by(1)
        end

        scenario "redirect to root_url" do
          click_button "送信"
          expect(page).to have_current_path root_url
        end

        scenario "display success message" do
          click_button "送信"
          expect(page).to have_selector(".alert-success")
        end

        scenario "display the menu in the menu registeration list" do
          click_button "送信"
          expect(page).to have_selector ".datetime",
                                        text: "#{@menu_date}　#{@menu_time}"
        end

        scenario "display the dish in the menu registeration list" do
          click_button "送信"
          expect(page).to have_selector ".dish", text: @dish_name
        end

        scenario "enter the same date in the form as last time" do
          click_button "送信"
          expect(page).to have_field "menu_date", with: @menu_date
        end

        scenario "enter the same time in the form as last time" do
          click_button "送信"
          expect(page).to have_select "menu_time", selected: @menu_time
        end
      end

      context "and existing menu" do
        background {
          @first_menu = create(:first_menu, user: @user)
          @first_dish = create(:first_dish, menu: @first_menu)
          @dish_category = "汁物"
          @dish_name = "味噌汁"
          visit root_url
          fill_in "menu_date", with: @first_menu.date
          select @first_menu.time, from: "menu_time"
          select @dish_category, from: "dish_category"
          fill_in "dish_name", with: @dish_name
        }

        scenario "not add a menu" do
          expect do
            click_button "送信"
          end.to change(Menu, :count).by(0)
        end

        scenario "add a dish" do
          expect do
            click_button "送信"
          end.to change(Dish, :count).by(1)
        end

        scenario "redirect to root_url" do
          click_button "送信"
          expect(page).to have_current_path(root_url)
        end

        scenario "display success message" do
          click_button "送信"
          expect(page).to have_selector(".alert-success")
        end

        scenario "display the dish in the menu registeration list" do
          click_button "送信"
          expect(page).to have_selector(".dish", text: @dish_name)
        end
      end
    end
  end

  feature "Posted menus list" do
    background { visit root_url }

    context "without logged-in user" do

      scenario "displayed" do
        expect(page).to have_selector ".menus"
      end
    end

    context "with logged-in user" do

      scenario "displayed" do
        expect(page).to have_selector ".menus"
      end
    end

    context "with more than 31 registers" do
      background {
        @first_menu = create(:"menu-#{0}", user: @user)
        for n in 1..30 do
          create(:"menu-#{n}", user: @user)
        end
      }

      scenario "show the oldest register on page 1" do
        expect(page).not_to have_selector "#menu-#{@first_menu.id}"
      end
    end

    context "with current_user = registered user" do
      background {
        log_in_as @user
        @menu = create(:menu, user: @user)
      }

      scenario "display button of '削除' in register list" do
        visit root_url
        expect(page).to have_link "削除"
      end
    end

    context "with current_user != registered user" do
      background {
        log_in_as @other_user
        @menu = create(:menu, user: @user)
      }

      scenario "not display button of '削除' in register list" do
        visit root_url
        expect(page).not_to have_link "削除"
      end
    end
  end
end

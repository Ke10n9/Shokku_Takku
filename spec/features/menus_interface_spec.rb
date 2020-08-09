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

    context "with current_user = registered user" do
      background {
        log_in_as @user
        @menu = create(:menu, user: @user)
      }

      scenario "display button of '編集' in register list" do
        visit root_url
        expect(page).to have_link "編集", href: "/menus/#{@menu.id}/edit"
      end
    end

    context "with current_user != registered user" do
      background {
        log_in_as @other_user
        @menu = create(:menu, user: @user)
      }

      scenario "not display button of '編集' in register list" do
        visit root_url
        expect(page).not_to have_link "編集", href: "/menus/#{@menu.id}/edit"
      end
    end
  end

  feature "Delete" do
    background {
      log_in_as @user
      @menu = create(:menu, user: @user)
      @dish = create(:dish, menu: @menu)
      @menu_id = @menu.id
      visit root_url
    }

    scenario "destory a menu in menus tabel" do
      expect do
        click_link "削除"
      end.to change(Menu, :count).by(-1)
    end

    scenario "destory a dish in dishes tabel" do
      expect do
        click_link "削除"
      end.to change(Dish, :count).by(-1)
    end

    scenario "redirect to root_url" do
      click_link "削除"
      expect(page).to have_current_path root_url
    end

    scenario "display success message" do
      click_link "削除"
      expect(page).to have_selector(".alert-success")
    end

    scenario "destroy a menu in register list" do
      click_link "削除"
      expect(page).not_to have_selector "#menu-#{@menu_id}"
    end
  end

  feature "Edit" do
    background {
      log_in_as @user
      @menu = create(:menu, user: @user)
      @dish_one = create(:dish, menu: @menu)
      @dish_two = create(:first_dish, menu: @menu)
      visit edit_menu_path(@menu)
    }

    scenario "display current date in the edit form" do
      expect(page).to have_field "menu_date", with: @menu.date
    end

    scenario "display current time in the edit form" do
      expect(page).to have_select "menu_time", selected: @menu.time
    end

    scenario "display the same category in the edit form" do
      expect(page).to have_select "dish_#{@dish_one.id}_category",
                                        selected: @dish_one.category
      expect(page).to have_select "dish_#{@dish_two.id}_category",
                                        selected: @dish_two.category
    end

    scenario "display the same name in the edit form" do
      expect(page).to have_field "dish_#{@dish_one.id}_name",
                                          with: @dish_one.name
      expect(page).to have_field "dish_#{@dish_two.id}_name",
                                          with: @dish_two.name
    end

    context "with invalid menu" do
      background {
        @previous_name = @dish_one.name
        fill_in "menu_date", with: ""
        fill_in "dish_#{@dish_one.id}_name", with: "edited name"
        click_button "確定"
      }

      scenario "not update data" do
        expect(@dish_one.name).to eq @previous_name
      end

      scenario "render edit page" do
        expect(page).to have_current_path "/menus/#{@menu.id}"
      end

      scenario "display danger message" do
        expect(page).to have_selector(".alert-danger")
      end

      scenario "is accepted normally if content is fixed after invalid edit" do
        @menu_date = Date.today
        fill_in "menu_date", with: @menu_date
        click_button "確定"
        expect(page).to have_selector(".alert-success")
      end
    end

    context "with duplicate menu" do
      background {
        @other_menu = create(:today_lunch, user: @user)
        @other_menu_dish = create(:second_dish, menu: @other_menu)
        fill_in "menu_date", with: @other_menu.date
        select @other_menu.time, from: "menu_time"
        click_button "確定"
        # @dish_oneのmenuが@other_menuに編集されているかの確認
        @dish_update = Dish.find_by(name: @dish_one.name,
                                    category: @dish_one.category,
                                    menu: @other_menu)
      }

      scenario "not update dish's menu" do
        expect(@dish_update).to be_falsy
      end

      scenario "render edit page" do
        expect(page).to have_current_path "/menus/#{@menu.id}"
      end

      scenario "display danger message" do
        expect(page).to have_selector(".alert-danger")
      end
    end

    context "with invalid dish" do
      background {
        @previous_date = @menu.date
        fill_in "menu_date", with: "2020-8-7"
        fill_in "dish_#{@dish_one.id}_name", with: ""
        click_button "確定"
      }

      scenario "not update data" do
        expect(@menu.date).to eq @previous_date
      end

      scenario "render edit page" do
        expect(page).to have_current_path "/menus/#{@menu.id}"
      end

      scenario "display danger message" do
        expect(page).to have_selector(".alert-danger")
      end

      scenario "is accepted normally if content is fixed after invalid edit" do
        @dish_one_name = "豚肉"
        fill_in "dish_#{@dish_one.id}_name", with: @dish_one_name
        click_button "確定"
        expect(page).to have_selector(".alert-success")
      end
    end

    context "with valid menu and dish" do
      background {
        @new_date = Date.today
        @new_time = "夕食"
        @new_dish_one = { name: "ハヤシライス", category: "主菜" }
        fill_in "menu_date", with: @new_date
        select @new_time, from: "menu_time"
        select @new_dish_one[:category], from: "dish_#{@dish_one.id}_category"
        fill_in "dish_#{@dish_one.id}_name", with: @new_dish_one[:name]
        click_button "確定"
        @menu.reload
        @dish_one.reload
      }

      scenario "update date of menu" do
        expect(@menu.date).to eq @new_date
      end

      scenario "update time of menu" do
        expect(@menu.time).to eq @new_time
      end

      scenario "update category of dish" do
        expect(@dish_one.category).to eq @new_dish_one[:category]
      end

      scenario "update name of dish" do
        expect(@dish_one.name).to eq @new_dish_one[:name]
      end

      scenario "redirect to root_url" do
        expect(page).to have_current_path root_url
      end

      scenario "display success message" do
        expect(page).to have_selector(".alert-success")
      end
    end
  end
end

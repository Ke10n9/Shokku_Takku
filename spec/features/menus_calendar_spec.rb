require 'rails_helper'

RSpec.feature "MenusCalendars", type: :feature do
  background {
    @user = create(:michael)
    log_in_as @user
    @other_user = create(:archer)

    #menu
    @menu_8days_ahead = create(:"menu--8", user: @user)
    @menu_7days_ahead = create(:"menu--7", user: @user)
    @menu_7days_ago = create(:"menu-7", user: @user)
    @menu_8days_ago = create(:"menu-8", user: @user)
    @menu_other_user = create(:"menu-0", user: @other_user)

    #dish
    @dish_8days_ahead = create(:dish, menu: @menu_8days_ahead)
    @dish_7days_ahead = create(:first_dish, menu: @menu_7days_ahead)
    @dish_7days_ago = create(:second_dish, menu: @menu_7days_ago)
    @dish_8days_ago = create(:dish, menu: @menu_8days_ago)
    @dish_other_user = create(:dish, menu: @menu_other_user)

    visit user_path(@user)
  }

  scenario "show today and 7days before and after by default" do
    (-7..7).each do |n|
      expect(page).to have_content(Date.today-n)
    end
  end

  scenario "don't show before 8days by default" do
    expect(page).not_to have_content(Date.today-8)
  end

  scenario "don't show after 8days by default" do
    expect(page).not_to have_content(Date.today+8)
  end

  scenario "don't show the menu 8days ahead by default" do
    expect(page).not_to have_content(@dish_8days_ahead.name)
  end

  scenario "show the menu 7days ahead by default" do
    expect(page).to have_content(@dish_7days_ahead.name)
  end

  scenario "show the menu 7days ahead by default" do
    expect(page).to have_content(@dish_7days_ago.name)
  end

  scenario "don't show the menu 8days ahead by default" do
    expect(page).not_to have_content(@dish_8days_ago.name)
  end

  scenario "don't show other user's menus" do
    expect(page).not_to have_content(@dish_other_user.name)
  end

  feature "calendarModal" do

    scenario "show simple-calendar in modal" do
      within("#calendarModal") do
        expect(page).to have_css(".simple-calendar")
      end
    end

    scenario "show this month by default" do
      within("#calendarModal") do
        expect(page).to have_content("#{Date.today.year}年 #{Date.today.month}月")
      end
    end

    scenario "show last month when the user click '<'" do
      within ("#calendarModal") do
        click_on "<"
        expect(page).to have_content("#{Date.today.prev_month.year}年 #{Date.today.prev_month.month}月")
      end
    end

    scenario "show next month when the user click '>'" do
      within ("#calendarModal") do
        click_on ">"
        expect(page).to have_content("#{Date.today.next_month.year}年 #{Date.today.next_month.month}月")
      end
    end

    scenario "show yesterday and 7days before and after yesterday in menu calendar when click_on yesterday" do
      within ("#calendarModal") do
        click_link href: user_path(@user, start_date: Date.yesterday)
      end
      (-7..7).each do |n|
        expect(page).to have_content(Date.yesterday-n)
      end
    end
  end

  feature "menuSearch" do
    background {
      @search_word = @dish_7days_ago[0]
      fill_in "search_name", with: @search_word
      click_on "献立検索"
    }

    scenario "show dish names containing entered characters" do
      expect(page).to have_content(@dish_7days_ago.name)
    end

    scenario "show menu date of dish containing entered characters" do
      expect(page).to have_content(@dish_7days_ago.menu.date)
    end

    scenario "show menu time of dish containing entered characters" do
      expect(page).to have_content(@dish_7days_ago.menu.time)
    end

    context "with 11 or more searched menus" do
      background {
        i = 10
        (10..24).each do |n|
          create(:"menu-#{n}", user: @user)
        end
        ["主菜", "副菜", "汁物"].each do |cat|
          5.times do |n|
            create(:"dinner-#{n}-#{cat}", menu: Menu.find_by(date: Date.today - (n+i)))
          end
          i = i + 5
        end

        fill_in "search_name", with: "dinner"
        click_on "献立検索"
      }

      scenario "show 10 new menus on the first page by pagination" do
        expect(page).not_to have_content("汁物")
      end

      scenario "show link to navigate pages" do
        expect(page).to have_css(".pagination")
      end

      scenario "show the second page when the user click pagination link" do
        click_on ">"
        expect(page).to have_content("汁物")
      end
    end

    context "with clicking searched dish" do
      background {
        click_on @dish_7days_ago.name
      }

      scenario "move the menu calendar to the clicked menu date" do
        expect(page).to have_content(@dish_7days_ago.name)
      end

      scenario "show 8days ago are not showed by default" do
        expect(page).to have_content(@dish_8days_ago.menu.date)
      end

      scenario "show 7days ahead are showed by default" do
        expect(page).not_to have_content(@dish_7days_ahead.menu.date)
      end
    end
  end
end

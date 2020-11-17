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
        click_on "#{Date.yesterday.day}"
      end
      (-7..7).each do |n|
        expect(page).to have_content(Date.yesterday-n)
      end
    end
  end
end

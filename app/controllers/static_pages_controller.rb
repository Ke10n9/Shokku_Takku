class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]
  before_action :set_menu_times, only: [:home]
  before_action :set_dish_categories, only: [:home]

  def home
    @menus = Menu.paginate(page: params[:page])
    logged_in? ? @user = @current_user : @user = User.new

    @menu = current_user.menus.build if logged_in?
    @dish = @menu.dishes.build if logged_in?
    @menu_date = Time.now.strftime("%Y-%m-%d")
    @menu_category = ""
  end
end

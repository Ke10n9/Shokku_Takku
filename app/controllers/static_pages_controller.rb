class StaticPagesController < ApplicationController
  before_action :set_menu_times, only: [:home]
  before_action :set_dish_categories, only: [:home]

  def home
    # /shared/_menu_form.html.erb
    @menu = current_user.menus.build if logged_in?
    @dish = @menu.dishes.build if logged_in?
    @menu_date = Time.now.strftime("%Y-%m-%d")
    @menu_category = ""

    # /menus/_menu.html.erb
    @menus = Menu.paginate(page: params[:page])
    logged_in? ? @user = @current_user : @user = User.new

  end
end

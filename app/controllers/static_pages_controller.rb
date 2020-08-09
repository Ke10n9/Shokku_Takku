class StaticPagesController < ApplicationController
  before_action :set_menu_times, only: :home
  before_action :set_dish_categories, only: :home
  append_after_action :delete_menu_sessions, only: :home

  def home
    # /shared/_menu_form.html.erb
    if logged_in?
      @menu = current_user.menus.build
      @dish = @menu.dishes.build
      if session[:menu_date].nil? || session[:menu_date].empty?
        @menu_date = Time.now.strftime("%Y-%m-%d")
      else
        @menu_date = session[:menu_date]
      end
      @menu_time = session[:menu_time] unless session[:menu_time].nil?
    end

    # /menus/_menu.html.erb
    @menus = Menu.paginate(page: params[:page])
    logged_in? ? @user = @current_user : @user = User.new

  end

  private

    def delete_menu_sessions
      session[:menu_date].clear unless session[:menu_date].nil?
      session[:menu_time].clear unless session[:menu_date].nil?
    end
end

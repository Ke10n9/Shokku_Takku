class StaticPagesController < ApplicationController
  before_action :set_menu_times, only: :home
  before_action :set_dish_categories, only: :home
  before_action :prepare_menu_form, only: :home
  append_after_action :delete_menu_sessions, only: :home

  def home
    # # /menus/_menu.html.erb
    @menus = Menu.page(params[:page]).per(30)

    @user = current_user if logged_in?
  end

  private

    def delete_menu_sessions
      session[:menu_date].clear unless session[:menu_date].nil?
      session[:menu_time].clear unless session[:menu_date].nil?
    end
end

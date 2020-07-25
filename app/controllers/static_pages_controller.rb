class StaticPagesController < ApplicationController
  def home
    @menus = Menu.paginate(page: params[:page])
    logged_in? ? @user = @current_user : @user = User.new
  end
end

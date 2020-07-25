class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :set_menu_times, only: [:new, :create]
  before_action :set_dish_categories, only: [:new, :create]

  def new
    @menu = current_user.menus.build if logged_in?
    @dishes = []
    if logged_in?
      @dish_categories.each do |dish_category|
        dish = @menu.dishes.build(name: "", category: dish_category[0])
        @dishes << dish
      end
    end
  end

  def create
    @menu = current_user.menus.build(menu_params)
    unless @menu.save
      render 'new' and return
    end
    err = 0
    @dishes = []
    dishes_params.each do |dish_params|
      dish = @menu.dishes.build(dish_params)
      @dishes << dish
    end
    @dishes.each do |dish|
      if !dish.name.empty?
        if dish.valid?
          dish.save
        else
          @menu.destroy
          render 'new' and return
        end
      end
    end
    flash[:success] = "メニューが登録されました。"
    redirect_to root_path
  end

  private

    def menu_params
      params.require(:menu).permit(:date, :time)
    end

    def dishes_params
      params.permit(dish: [:name, :category])[:dish]
    end
end

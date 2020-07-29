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
    @menus = Menu.paginate(page: params[:page])
    logged_in? ? @user = @current_user : @user = User.new
    menu = Menu.find_by(menu_params, user: current_user)
    menu.nil? ? @menu = current_user.menus.build(menu_params) : @menu = menu
    if @menu.valid?
      @dish = @menu.dishes.build(dish_params)
      if @dish.valid?
        @menu.save if menu.nil?
        @dish.save
        flash[:success] = "メニューを登録しました。"
        redirect_to root_url
      else
        render 'static_pages/home' and return
      end
    else
      @dish = @menu.dishes.build(dish_params)
      render 'static_pages/home'
    end
    # /menus/new
    # if @menu.valid?
    #   @menu.save
    # else
    #   save_failed = 1
    # end
    #
    # @dishes = []
    # dishes_params.each do |dish_params|
    #   dish = @menu.dishes.build(dish_params)
    #   @dishes << dish
    # end
    #
    # unless save_failed == 1
    #   @dishes.each do |dish|
    #     unless dish.name == ""
    #       if dish.valid?
    #         dish.save
    #       else
    #         @menu.destroy
    #         render 'new' and return
    #       end
    #     end
    #   end
    # else
    #   render 'new' and return
    # end
    #
    # flash[:success] = "メニューが登録されました。"
    # redirect_to root_path
  end

  private

    def menu_params
      params.require(:menu).permit(:date, :time)
    end

    def dish_params
      params.permit(dish: [:name, :category])[:dish]
    end

    def dishes_params
      params.permit(dish: [:name, :category])[:dish]
    end
end

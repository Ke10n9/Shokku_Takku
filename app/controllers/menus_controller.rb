class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_menu_times, only: [:new, :create, :edit, :update]
  before_action :set_dish_categories, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

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

    menu = Menu.find_by(date: menu_params[:date], time: menu_params[:time],
                        user: current_user)
    menu.nil? ? @menu = current_user.menus.build(menu_params) : @menu = menu
    @dish = @menu.dishes.build(dish_params)
    @menu_date = menu_params[:date]
    @menu_time = menu_params[:time]
    @dish_name = dish_params[:name]
    @dish_category = dish_params[:category]
    if menu.nil?
      unless @menu.valid?
        render 'static_pages/home' and return
      end
    end
    if @dish.valid?
      @menu.save
      @dish.save
      flash[:success] = "メニューを登録しました。"
      session[:menu_date] = @menu_date
      session[:menu_time] = @menu_time
      redirect_to root_url
    else
      @menu = current_user.menus.build
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

  def destroy
    @menu.destroy
    flash[:success] = "メニューを削除しました。"
    redirect_to request.referrer || root_url
  end

  def edit
    @menu = Menu.find(params[:id])
    @dishes = @menu.dishes.all
  end

  def update
    @menu = Menu.find(params[:id])
    err = 0
    @dishes = []

    dishes_params.keys.each do |dish_id|
      dish = Dish.find(dish_id)
      dish.assign_attributes({ name: dishes_params[dish_id][:name],
                              category: dishes_params[dish_id][:category] })
      @dishes << dish
      err = 1 unless dish.valid?
    end

    if @menu.update(menu_params) && err == 0
      @dishes.each do |dish|
        dish.save
      end
      flash[:success] = "メニューを編集しました。"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

    def menu_params
      params.require(:menu).permit(:date, :time, :picture)
    end

    def dish_params
      params.permit(dish: [:name, :category])[:dish]
    end

    def dishes_params
      params.permit(dish: [:name, :category])[:dish]
    end

    def correct_user
      @menu = current_user.menus.find_by(id: params[:id])
      redirect_to root_url if @menu.nil?
    end
end

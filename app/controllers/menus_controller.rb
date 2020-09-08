class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_menu_times, only: [:new, :create, :edit, :update]
  before_action :set_dish_categories, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :prepare_menu_form, only: [:new, :create]

  def new
    # @menu = current_user.menus.build if logged_in?
    # @dishes = []
    # if logged_in?
    #   @dish_categories.each do |dish_category|
    #     dish = @menu.dishes.build(name: "", category: dish_category[0])
    #     @dishes << dish
    #   end
    end

    # respond_to do |format|
    #   format.html{ redirect_to new_menu_path, notice: 'User was successfully created.' }
    #   format.js {}
    # end
  # end

  def create
    @menuform = MenuForm.new(menuform_params)
    @menuform.save
    # @menu = current_user.menus.build(menu_params)
    # @menu.save
    # @dishes = []
    # dishes_params.each do |dish_params|
    #   dish = @menu.dishes.build(dish_params)
    #   # @dishes << dish
    #   dish.save
    # end
    # @dishes.each do |dish|
    #   dish.save
    # end

    # @menu = Menu.find_by(date: menus_params[:date], time: menus_params[:time])
    # @dish = @menu.dishes.build(menus_params[:dishes_attributes])
    # @dish.save
    redirect_to @current_user

    # @menus = Menu.paginate(page: params[:page])
    # logged_in? ? @user = @current_user : @user = User.new
    #
    # menu = Menu.find_by(date: menu_params[:date], time: menu_params[:time],
    #                     user: current_user)
    # menu.nil? ? @menu = current_user.menus.build(menu_params) : @menu = menu
    # @dish = @menu.dishes.build(dish_params)
    # @menu_date = menu_params[:date]
    # @menu_time = menu_params[:time]
    # @dish_name = dish_params[:name]
    # @dish_category = dish_params[:category]
    # if menu.nil?
    #   unless @menu.valid?
    #     render 'static_pages/home' and return
    #   end
    # end
    # if @dish.valid?
    #   @menu.save
    #   @dish.save
    #   flash[:success] = "メニューを登録しました。"
    #   session[:menu_date] = @menu_date
    #   session[:menu_time] = @menu_time
    #   redirect_to root_url
    # else
    #   @menu = current_user.menus.build
    #   render 'static_pages/home'
    # end

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
      # params.require(:menu).permit(:date, :time, :picture)
      params.require(:menu).permit(
        :date,
        :time,
        dishes_attributes: [:name, :category]
      )
    end

    # def menus_params
    #   # params.require(:menu).permit(:date, :time, :picture)
    #   params.require(:menu).permit(
    #     :date,
    #     :time,
    #     :picture,
    #     dishes_attributes: [:category,
    #                         :name]
    #   ).merge(user_id: current_user.id)
    # end

    # def dish_params
    #   params.permit(dish: [:name, :category])[:dish]
    # end

    def dishes_params
      params.require(:dish).permit(:name, :category)[:dish]
    end

    def correct_user
      @menu = current_user.menus.find_by(id: params[:id])
      redirect_to root_url if @menu.nil?
    end

    def menuform_params
      params.require(:menu)
            .permit(:date, :time, :category, :name)
            .merge(user_id: current_user.id)
    end
end

class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_menu_times, only: [:new, :create, :edit, :update]
  before_action :set_dish_categories, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :prepare_menu_form, only: [:new, :create]

  def new
    @menu = current_user.menus.build if logged_in?
    @dishes = []
    if logged_in?
      @dish_categories.each do |dish_category|
        dish = @menu.dishes.build(name: "", category: dish_category[0])
        @dishes << dish
      end
    end
    @menuform = MenuForm.new

    # respond_to do |format|
    #   format.html{ redirect_to new_menu_path, notice: 'User was successfully created.' }
    #   format.js {}
    # end
  end

  def create
    @menuform = MenuForm.new(menuform_params)
    dish_count = Dish.count
    if @menuform.save
      render :success
      flash[:success] = "品名が入力されていませんでした。" if Dish.count == dish_count
    else
      render :error
    end
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

  def index
    @menus = Menu.paginate(page: params[:page])
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

    def dishes_params
      params.require(:dish).permit(:name, :category)[:dish]
    end

    def correct_user
      @menu = current_user.menus.find_by(id: params[:id])
      redirect_to root_url if @menu.nil?
    end

    def menuform_params
      params.require(:menu).permit(
        :date,
        :time,
        :picture,
        dishes_attributes: [ :category, :name ]
      ).merge(user_id: current_user.id)
    end
end

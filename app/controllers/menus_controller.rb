class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_menu_times, only: [:new, :create, :edit, :update]
  before_action :set_dish_categories, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :prepare_menu_form, only: [:new, :create]

  def new
    @menu = current_user.menus.build(date: Date.today) if logged_in?
    @dishes = []
    if logged_in?
      @dish_categories.each do |dish_category|
        dish = @menu.dishes.build(name: "", category: dish_category[0])
        @dishes << dish
      end
    end
  end

  def create
    dishes = []
    if @menu = Menu.find_by(date: menu_params[:date], time: menu_params[:time])
    #       || current_user.menus.build(date: menu_params[:date], time: menu_params[:time])
    # if @menu.save
      menu_params[:dishes_attributes].each do |dish_params|
        unless dish_params[:name] == ""
          @dish = @menu.dishes.build(dish_params)
          if @dish.valid?
            dishes << @dish
          else
            render :error and return
          end
        end
      end
      @menu.save
      dishes.each do |dish|
        dish.save
      end
      render :success
    else
      @menu = current_user.menus.build(date: menu_params[:date], time: menu_params[:time])
      if @menu.valid?
        menu_params[:dishes_attributes].each do |dish_params|
          unless dish_params[:name] == ""
            @dish = @menu.dishes.build(dish_params)
            if @dish.valid?
              dishes << @dish
            else
              render :error and return
            end
          end
        end
        @menu.save
        dishes.each do |dish|
          dish.save
        end
        render :success
      else
        render :error
      end
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
    if @menu.update_attributes(date: menu_params[:date], time: menu_params[:time])
      menu_params[:dishes_attributes].keys.each do |dish_id|
        @dish = Dish.find(dish_id)
        @dish.assign_attributes({ name: menu_params[:dishes_attributes][dish_id][:name],
                                category: menu_params[:dishes_attributes][dish_id][:category] })
        unless @dish.save
          render :error and return
        end
      end
      flash[:success] = "メニューを編集しました。"
      render :success
    else
      render :error
    end
  end

  def index
    @menus = Menu.paginate(page: params[:page])
  end

  private
    def menu_params
      params.require(:menu).permit(
        :date,
        :time,
        :picture,
        dishes_attributes: [
          :name,
          :category#,
          # :dish_id
        ]
      )
    end

    def correct_user
      @menu = current_user.menus.find_by(id: params[:id])
      redirect_to root_url if @menu.nil?
    end

    # def menuform_params
    #   params.require(:menu).permit(
    #     :date,
    #     :time,
    #     :picture,
    #     dishes: [ :category, :name ]
    #   ).merge(user_id: current_user.id)
    # end
end

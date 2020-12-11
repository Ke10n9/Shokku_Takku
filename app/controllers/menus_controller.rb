class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :set_menu_times, only: [:new, :create, :edit, :update]
  before_action :set_dish_categories, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :prepare_menu_form, only: [:new, :create]

  def new
    if params[:menu]
      @menu = Menu.find(params[:menu])
    else
      @menu = current_user.menus.build(date: Date.today)
    end
    @dishes = []
    @dish_categories.each do |dish_category|
      dish = @menu.dishes.build(name: "", category: dish_category[0])
      @dishes << dish
    end
  end

  def create
    dishes = []
    if @menu = Menu.find_by(date: menu_params[:date],
                            time: menu_params[:time])
      @menu.assign_attributes(picture: menu_params[:picture])
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
      if menu_params[:picture].nil? && dishes.empty?
        flash[:success] = "品目や画像の入力がありませんでした。"
      else
        @menu.save
        dishes.each do |dish|
          dish.save
        end
        flash[:success] = "献立が編集されました。"
      end
      redirect_to user_path(current_user, start_date: @menu.date)
    else
      @menu = current_user.menus.build(date: menu_params[:date],
                                        time: menu_params[:time],
                                        picture: menu_params[:picture])
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
        if dishes.empty?
          flash[:success] = "品目の入力がありませんでした。"
        else
          @menu.save
          dishes.each do |dish|
            dish.save
          end
          flash[:success] = "献立が作成されました。"
        end
        redirect_to user_path(current_user, start_date: @menu.date)
      else
        render :error
      end
    end
  end

  def destroy
    @menu.destroy
    flash[:success] = "献立を削除しました。"
    redirect_to request.referrer || root_url
  end

  def edit
    @menu = Menu.find(params[:id])
    @dishes = @menu.dishes.all
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(date: menu_params[:date],
                                time: menu_params[:time],
                                picture: menu_params[:picture])
      unless menu_params[:dishes_attributes] = ""
        menu_params[:dishes_attributes].keys.each do |dish_id|
          @dish = Dish.find(dish_id)
          @dish.assign_attributes({ name: menu_params[:dishes_attributes][dish_id][:name],
                                  category: menu_params[:dishes_attributes][dish_id][:category] })
          unless @dish.save
            render :error and return
          end
        end
      end
      flash[:success] = "献立が編集されました。"
      redirect_to user_path(current_user, start_date: @menu.date)
    else
      render :error
    end
  end

  def index
    @menus = Menu.page(params[:page]).per(30)

    @followings_menus = Menu.where(user: current_user.following)
    @followings_menus = Kaminari.paginate_array(@followings_menus).page(params[:page]).per(30)
  end

  private
    def menu_params
      params.require(:menu).permit(
        :date,
        :time,
        :picture,
        dishes_attributes: [
          :name,
          :category
        ]
      )
    end

    def correct_user
      @menu = current_user.menus.find_by(id: params[:id])
      redirect_to root_url if @menu.nil?
    end
end

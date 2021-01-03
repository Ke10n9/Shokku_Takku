class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # before_action

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def logged_in_testuser
      if current_user == User.find_by(email: "test@railstutorial.org")
        flash[:danger] = "テストユーザーでは利用できません。"
        redirect_to root_url
      end
    end

    # mealsモデルのeating_timeカラムのバリエーションを指定
    def set_menu_times
      @menu_times = [["朝食", "朝食"], ["昼食", "昼食"], ["夕食", "夕食"]]
    end

    # dishesモデルのcategoryカラムのバリエーションを指定
    def set_dish_categories
      @dish_categories = [["主菜", "主菜"], ["副菜", "副菜"], ["汁物", "汁物"], ["他", "他"]]
    end

    # views/share/_menu_form.html.erbに使用する変数を準備
    def prepare_menu_form
      if logged_in?
        if params[:id]
          menu = Menu.find(params[:id])
          @menu_date = menu.date
          @menu_time = menu.time
        elsif params[:menu_date] || params[:menu_time]
          @menu_date = params[:menu_date] if params[:menu_date]
          @menu_time = params[:menu_time] if params[:menu_time]
        else
          @menu_date = Time.now.strftime("%Y-%m-%d")
        end
      end
    end
end

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

    # mealsモデルのeating_timeカラムのバリエーションを指定
    def set_menu_times
      @menu_times = [["朝食", "朝食"], ["昼食", "昼食"], ["夕食", "夕食"]]
    end

    # dishesモデルのcategoryカラムのバリエーションを指定
    def set_dish_categories
      @dish_categories = [["主菜", "主菜"], ["副菜", "副菜"], ["汁物", "汁物"], ["その他", "その他"]]
    end
end

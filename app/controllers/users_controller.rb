class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show,
                                        :following, :followers]
  before_action :correct_user, only: [:edit, :update, :following, :followers]
  before_action :correct_or_admin_user, only: :destroy
  before_action :set_menu_times, only: :show
  before_action :set_dish_categories, only: :show
  before_action :logged_in_testuser, only: [:edit, :update]

  def index
    @search_params = user_search_params
    if current_user.admin?
      @users = User.where(activated: true)
                  .where.not(id: current_user.id).admin_search(@search_params)
    else
      @users = User.where(activated: true)
                  .where.not(id: current_user.id).search(@search_params)
    end

    if @users
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(30)
    else
      flash[:danger] = "一致するユーザーがいませんでした。
                        入力したユーザー名と完全に一致するユーザーのみを表示します。"
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?

    # menus/menu_calendar
    params[:start_date] ? @date = params[:start_date].to_date : @date = Date.today
    @menus = @user.menus.all
    @menus = Kaminari.paginate_array(@menus).page(params[:page]).per(30)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "メールを確認して、アカウントを有効にしてください。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      flash[:danger] = "管理者は削除できません。"
      redirect_to root_path
    else
      @user.destroy
      if current_user.admin?
        flash[:success] = "ユーザーを削除しました。"
        redirect_to users_path
      else
        flash[:success] = "ご利用ありがとうございました。"
        redirect_to root_path
      end
    end
  end

  def following
    @title = "フォロー"
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation, :picture)
    end

    def user_search_params
      params.fetch(:search, {}).permit(:name)
    end

    # beforeアクション

    # ユーザーが本人かどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # ユーザーが本人または管理者かどうか確認
    def correct_or_admin_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        redirect_to(root_url)
      end
    end
end

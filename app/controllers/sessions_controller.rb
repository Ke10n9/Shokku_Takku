class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:danger] = "既にログイン中です。"
      redirect_to root_url
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        flash[:success] = "ログインしました。"
        redirect_back_or root_url
      else
        message  = "アカウントが有効化されていません。"
        message += "メールをご確認ください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが不正です。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

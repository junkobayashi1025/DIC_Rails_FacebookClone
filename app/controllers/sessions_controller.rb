class SessionsController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :destroy]}
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'home/index'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end

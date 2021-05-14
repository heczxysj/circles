class UserController < ApplicationController

  before_action :auth_user, only: [:index]
  protect_from_forgery except: :index  ###除了index,controller里的其他action都需要验证
  #protect_from_forgery only: :index  ####只有index需要验证
  def index
    # ||逻辑或 如果不传参数进来，默认使用||后面的参数：|| 10   如果不传参数进来，默认使用10
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10).order("id desc")
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.new(params.require(:user).permit(:username, :password))
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      flash[:notice] = "注册成功，请登录"
      redirect_to new_session_path
    else
      # render :'user/new'
      render action: :new
    end
  end

  private
  def auth_user
    unless session[:user_id]
      flash[:notice] = "请登录"
      redirect_to new_session_path
    end
  end
end

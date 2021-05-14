class SessionController < ApplicationController
  
  #protect_from_forgery except: :index  ###除了index,controller里的其他action都需要验证
  # protect_from_forgery only: :create  ####只有index需要验证
  def new
  end

  def create
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      cookies[:user_username] = @user.username
      flash[:notice] = "登录成功"
      redirect_to root_path
    else
      flash[:notice] = "用户名或密码不正确"
      render action: :new   #Rendering 是特别要告诉Controller 中的methods，要哪个view file来显示给用户。We can show Views as we wish!
    end
  end

  def show; end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "退出成功"
    redirect_to root_path   #另一个控制view内容的方法是redirect, 它跟rendering有点类似，不过它是重新发送一次request到一个different URL. redirect显示了一个不同的view,Redirecting 产生了一个全新的request.
  end
end

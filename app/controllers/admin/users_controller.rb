class Admin::UsersController < ApplicationController

  layout 'admin'

  def index
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id asc').where(['username like ?', "%#{params[:username]}%"])
    total = @users.count
    # 返回json格式数据
    render json: { res: @users, total: total }
  end

  def search
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id asc')
                 .where(['username like ?', "%#{params[:username]}%"])
    total = @users.count
    # render action: :index
    render json: { res: @users, total: total }
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render json: { res: @user }
    else
      render json: { msg: '该用户不存在' }
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(password: params[:password])
      render json: { msg: 'success' }
    else
      render json: { msg: 'failed' }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end

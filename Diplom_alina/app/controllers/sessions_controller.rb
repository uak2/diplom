class SessionsController < ApplicationController

  skip_filter :load_current_user, :set_current_permissions

  def new
  end

  def create
    @user = User.where("login=?", params[:login]).take
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @user.last_login=Time.new+3.hour
      @user.save
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end

end

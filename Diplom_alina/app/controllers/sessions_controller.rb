class SessionsController < ApplicationController

  skip_filter :load_current_user

  def new
  end

  def create
    @user = User.where("login=?", params[:login]).take
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
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

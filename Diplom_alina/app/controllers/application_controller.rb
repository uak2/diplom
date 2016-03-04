class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_accessor :logotype_name, :current_user
  before_filter :load_current_user
  before_action :set_logotype_name

  def load_current_user
    @current_user = User.where('id'=>session[:user_id]).first;
    return redirect_to '/login' unless @current_user
  end


  def set_logotype_name
    self.logotype_name="Diplom"
  end
end

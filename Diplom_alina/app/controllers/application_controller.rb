class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_accessor :logotype_name, :current_user
  before_filter :load_current_user
  before_action :set_logotype_name


  def load_current_user
    @current_user = User.includes(:roles).where(id: session[:user_id]).first
    return redirect_to '/login' unless @current_user
    @current_user.active_role_id = @current_user.roles.first.id if @current_user.active_role_id.nil?
  end

  def set_logotype_name
    self.logotype_name="Diplom"
  end

  #for datepicker
  def process_date(date)
    arr = date.split("/")
    return Time.new(arr[2], arr[0], arr[1], nil, nil, nil, "+00:00")
  end
end

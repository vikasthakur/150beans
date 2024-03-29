class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :adjust_format_for_mobile_devices
  before_filter :save_return_to

  def adjust_format_for_mobile_devices
    if request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod|BlackBerry|Android|Mobile)/]
      # request.format = :mobile
    elsif request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPad|PlayBook)/]
      # request.format = :tablet
    end
  end
  
  def save_return_to
    session[:return_to] = request.referer
  end
  
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :saved_return_to

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Mongoid::Errors::DocumentNotFound
        nil
      end
    end
    
    def user_signed_in?
      return true if current_user
    end
    
    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end
    
    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => "You need to sign in for access to this page."
      end
    end

    def saved_return_to
      session[:return_to]
    end

end

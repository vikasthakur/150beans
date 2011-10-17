class SessionsController < ApplicationController
  # auth returned by the service provider when authentication is successful.
  def create
    auth = request.env["omniauth.auth"]
    user = User.where("authorizations.provider" => auth['provider'], "authorizations.uid" => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to home_url, :notice => "Signed in!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
  
  def new
    # TODO redirect to login page for login method selector
    # redirect_to '/auth/tsina'
    redirect_to '/auth/twitter'
  end
  
  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
end

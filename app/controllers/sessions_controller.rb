class SessionsController < ApplicationController
  # auth returned by the service provider when authentication is succesful.
  def create
    auth = request.env["omniauth.auth"]
    user = User.where("identities.provider" => auth['provider'], "identities.uid" => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
  
  # TODO: login page
  def new
    redirect_to '/auth/tsina'
  end
  
  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
end

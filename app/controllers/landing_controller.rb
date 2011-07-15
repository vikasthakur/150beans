class LandingController < ApplicationController
  def index
    if user_signed_in?
      redirect_to home_url
    end
  end
  
  def home
    if user_signed_in?
    else
      redirect_to root_url, :alert => "You must sign in first!"
    end
  end
end

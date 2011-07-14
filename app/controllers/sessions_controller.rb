class SessionsController < ApplicationController
  # For now, we’ll set up the SessionsController to simply raise an exception and 
  # show the information returned by the service provider when authentication is succesful.
  def create
    raise request.env["omniauth.auth"].to_yaml
  end
end

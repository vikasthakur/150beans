# landing page controller
class LandingController < ApplicationController
  def index
    respond_to do |format|
      format.html # show index.html.haml
    end
  end
end

class WelcomeController < ApplicationController

  before_action :redirect_if_logged_in!, only: [:index]

  layout 'empty'

  def index
  end

  private def redirect_if_logged_in!
    redirect_to user_path current_user if logged_in?
  end
end

class SessionController  < ApplicationController
  include SessionHelper

  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      user.remember
      redirect_to root_path
    else
      redirect_to login_path, flash: { alert: "メールアドレスかパスワードのいずれかが間違えております" }
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end

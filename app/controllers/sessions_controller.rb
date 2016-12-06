class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: User.format(params[:session][:email]))
    if user && user.authenticate(params[:session][:password])
      if user.email_confirmed
        log_in user
        redirect_to user
      else
        flash.now[:error] = 'Please activate your account to proceed'
        render 'new'
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end

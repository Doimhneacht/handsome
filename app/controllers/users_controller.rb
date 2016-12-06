class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      redirect_to root_path, flash: {success: 'Please confirm your email address to continue'}
    else
      render 'new'
    end
  end

  def confirm_email # GET /users/:confirm_token/confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.activate_email
      flash[:success] = 'Your email has been confirmed. Welcome!'
      log_in(user)
    else
      flash[:error] = 'Sorry, user does not exist'
    end
    redirect_to root_path
  end

  def show # GET /users/:id

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end

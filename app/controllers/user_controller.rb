class UserController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    user.email = user.email.downcase
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      puts user.errors.messages
      @duplicate = true
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end

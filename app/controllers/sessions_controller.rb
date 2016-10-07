class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(user_params[:username],user_params[:password])
    if user
      login(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to session_new_url
    end
  end

  def destroy
    logout(current_user)
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

class UsersController < ApplicationController
  def home
  end

  def edit_account
    @user = current_user
  end

  def account_update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_home_path
    else
      render "users/edit_account", status: :unprocessable_entity
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:profile, :image, :name)
    end

end

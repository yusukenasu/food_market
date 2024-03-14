class UsersController < ApplicationController
  def home; end

  def edit_profile
    @user = current_user
  end

  def profile_update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_home_path
    else
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile, :image, :name)
  end
end

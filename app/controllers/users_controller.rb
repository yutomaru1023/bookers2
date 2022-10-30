class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.all
  end


  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
   if @user.save
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user.id)
   else
     render :edit
   end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  before_action :ensure_correct_user, only:[:edit]

   def ensure_correct_user
    @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path(current_user)
   end
 end
end
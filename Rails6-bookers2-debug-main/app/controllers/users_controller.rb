class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  before_action :ensure_correct_user, {only: [:edit, :update]}
  def ensure_correct_user
  	if current_user.id != params[:id].to_i
  		redirect_to user_path(current_user.id)
  	end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end

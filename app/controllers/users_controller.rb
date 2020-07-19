class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update]

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def update
    @user = User.find(params[:id])

  if @user.update(user_params)
    flash[:success] = "User was successfully updated."
    redirect_to user_path(@user.id)
  else
    render action: :edit
  end
  end

  def create
  end

  def destroy
  end

  private 
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@book = Book.new
  	@user = current_user
  	@users = User.all
  end

  def show
  	@book = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
       if current_user.id != @user.id
       redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
  	@user_id = current_user.id
  	@user.save
      if @user.save
         flash[:notice] = "Welcome! You have signed up successfully."
         redirect_to ("/user/show")
      else
         render("/users/sign_up")
      end
  end

  def update
		@user =User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
        else
        render("users/edit")
    end
  end

private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
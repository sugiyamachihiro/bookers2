class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
  	@user = current_user
  	@books = Book.all
  end

  def show
    @bookn = Book.new
  	@book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
       redirect_to books_path
    end
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
  	@book.user_id = current_user.id
  	@book.save
     if @book.save
       flash[:notice] = "You have creatad book successfully."
       redirect_to book_path(@book.id)
    else
      render("index")
    end
  end

  def update
		@book =Book.find(params[:id])
		@book.update(book_params)
    if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
     else
        render("edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
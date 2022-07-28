class BooksController < ApplicationController


  before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  protected

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

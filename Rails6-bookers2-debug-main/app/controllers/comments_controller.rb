class CommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = Comment.new(comments_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = book.comments.find(params[:id])
    comment.user_id = current_user.id
    comment.book_id = book.id
    if current_user.id == comment.user.id
      comment.destroy
      redirect_to book_path(book)
    else
      render :show
    end
  end

  protected

  def comments_params
    params.require(:comment).permit(:comment)
  end

end
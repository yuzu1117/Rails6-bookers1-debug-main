class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.save
    render :comments
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])
    @comment.destroy
    render :comments
  end

  protected

  def comments_params
    params.require(:comment).permit(:comment)
  end

end
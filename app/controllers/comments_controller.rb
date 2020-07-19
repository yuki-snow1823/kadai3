class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:id])
    comment = current_user.comments.new(comment_params)
    comment.book_id = @book.id
    comment.save
    redirect_to book_path(@book)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end

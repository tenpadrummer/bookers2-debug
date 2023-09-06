class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = book.book_comments.new(book_comment_params)
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = book.book_comments.find_by(book_id: book.id, user_id: current_user.id)
    comment.destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment).merge(user_id: current_user.id)
  end
end

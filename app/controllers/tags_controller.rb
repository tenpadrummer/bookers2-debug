class TagsController < ApplicationController
  def search
    @category = params[:category]
    @books = Book.where("category LIKE?","%#{@category}%")
    @new_book = Book.new
  end
end

class SearchesController < ApplicationController
  def search
    @new_book = Book.new
    @keyword = params[:keyword]
    @model_label = params[:model_label]
    @match_label =params[:match_label]
    if @model_label == "1"
      @results = User.search(@keyword, @match_label)
    else
      @results = Book.search(@keyword, @match_label)
    end
  end
end

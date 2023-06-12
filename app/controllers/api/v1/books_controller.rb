class Api::V1::BooksController < ApplicationController

  def search
    book_search = BookSearchFacade.new.get_details(params[:location], params[:quantity])
    render json: BookSearchSerializer.new(book_search)
  end
end

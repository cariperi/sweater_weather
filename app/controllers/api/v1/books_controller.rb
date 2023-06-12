class Api::V1::BooksController < ApplicationController
  before_action :check_for_location, only: [:search]

  def search
    book_search = BookSearchFacade.new.get_details(params[:location], params[:quantity])
    render json: BookSearchSerializer.new(book_search)
  end

  private

  def check_for_location
    return unless params[:location].empty?

    render json: { errors: [{ detail: 'Search cannot be completed with the given information.' }] }, status: 400
  end
end

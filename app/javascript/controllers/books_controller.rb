class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  # before_action :authenticate_user!

  def index
    @q = Book.ransack(params[:q])
    @pagy, @books = pagy(@q.result(distinct: true))
  end

  def show; end

  def new
    @book = Book.new
    authorize @book
  end
end

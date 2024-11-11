class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy, :borrow, :return]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  def borrow
    borrowing = current_user.borrowings.build(book: @book, due_date: 2.weeks.from_now)
    if borrowing.save
      @book.update(available: false)
      redirect_to @book, notice: 'Book was successfully borrowed.'
    else
      redirect_to @book, alert: borrowing.errors.full_messages.join(', ')
    end
  end

  def return
    borrowing = @book.borrowings.find_by(user: current_user, returned_date: nil)
    if borrowing&.update(returned_date: Time.current)
      @book.update(available: true)
      redirect_to @book, notice: 'Book was successfully returned.'
    else
      redirect_to @book, alert: 'Could not return book.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :author, :description, :category_id, :available)
  end

  def not_found
    redirect_to books_path, alert: 'Book not found.'
  end
end
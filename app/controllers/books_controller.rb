class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :borrow, :return]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
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
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully deleted.'
  end

  def borrow
    if @book.available?
      borrowing = current_user.borrowings.build(
        book: @book,
        due_date: 2.weeks.from_now
      )
      
      if borrowing.save
        @book.update(available: false)
        redirect_to @book, notice: 'Book was successfully borrowed.'
      else
        redirect_to @book, alert: 'Unable to borrow book.'
      end
    else
      redirect_to @book, alert: 'Book is not available.'
    end
  end

  def return
    borrowing = @book.borrowings.where(user: current_user, returned_date: nil).first
    
    if borrowing
      borrowing.update(returned_date: Time.current)
      @book.update(available: true)
      redirect_to @book, notice: 'Book was successfully returned.'
    else
      redirect_to @book, alert: 'No active borrowing found for this book.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :author, :description, :category_id, :available)
  end
end
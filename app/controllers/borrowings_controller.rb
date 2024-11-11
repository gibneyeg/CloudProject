class BorrowingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @borrowings = if current_user.admin?
                    Borrowing.all
                  else
                    current_user.borrowings
                  end
  end

  def show
    @borrowing = Borrowing.find(params[:id])
  end

  def new
    @borrowing = Borrowing.new
  end

  def create
    @borrowing = current_user.borrowings.build(borrowing_params)
    if @borrowing.save
      redirect_to @borrowing, notice: 'Borrowing was successfully created.'
    else
      render :new
    end
  end

  private

  def borrowing_params
    params.require(:borrowing).permit(:book_id, :due_date)
  end
end
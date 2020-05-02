class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  def index
    @bookings = current_user.bookings.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(bookings_params)
      redirect_to bookings_path(@booking)
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to bookings_path
  end

  def eaters
    @bookings = Meal.find(params[:id]).bookings
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:booking).permit(:date, :eaters, :user_id, :meal_id)
  end
end

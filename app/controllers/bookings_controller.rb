class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(bookings_params)

    if @booking.save
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

  private

  def bookings_params
    params.require(:booking).permit(:date, :eaters, :user_id, :meal_id)
  end

end

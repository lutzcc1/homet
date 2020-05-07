class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  def index
    @bookings = current_user.bookings.all
  end

  def show
    @meal = Booking.find(params[:id]).meal
    @booking = Booking.find(params[:id])

    if @booking.meal.reviews.where(user: current_user).empty?
      @review = Review.new
    else
      @review = @booking.meal.reviews.where(user: current_user).first
    end
  end

  def create
    @booking = Booking.new(bookings_params)
    @meal = Meal.find(params[:meal_id])
    @booking.meal = @meal
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to @meal
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(bookings_params)
      redirect_to booking_path(@booking)
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
    params[:booking][:date] = DateTime.parse("#{params[:booking][:date]} #{params[:booking]['time(5i)']}")
    params.require(:booking).permit(:date, :eaters, :user_id, :meal_id)
  end
end

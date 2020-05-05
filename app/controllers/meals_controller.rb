class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: %i[edit update destroy show]

  def home
    @meals = Meal.all
  end


  def show
    if @meal.bookings.where(user: current_user).empty?
      @booking = Booking.new
    else
      @booking = @meal.bookings.where(user: current_user).first
    end
  end

  def offered
    @meals = current_user.meals.all
  end

  def new
    @meal = Meal.new()
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @meal.update(meal_params)
      redirect_to meal_path(@meal)
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to offered_meals_path
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params[:meal].parse_time_select! :open_hrs
    params[:meal].parse_time_select! :close_hrs
    params.require(:meal).permit(:name,
                                 :description,
                                 :price,
                                 :address,
                                 :min_eaters,
                                 :max_eaters,
                                 :open_hrs,
                                 :close_hrs,
                                 open_days: []
                                 )
  end
end

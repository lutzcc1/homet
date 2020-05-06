require 'byebug'
class MealsController < ApplicationController
  before_action :set_meal, only: %i[edit update destroy]

  def home
    @meals = Meal.all
  end


  def show
    @meal = Meal.find(params[:id])
    @meal_owner = @meal.user
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
    @meal.user_id = params[:user_id] # is there a better way to do this?
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
    params.require(:meal).permit(:name, :description, :price, :address, :min_eaters, :max_eaters)
  end
end

class MealsController < ApplicationController
  before_action :set_meal, only: %i[edit update destroy]

  def new
    @meal = Meal.new()
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      # redirect_to meal_path(@meal)
      true
    else
      render :new
    end
  end

  def edit; end

  def update
    @meal.update(meal_params)
    if @meal.save
      # redirect_to meal_path(@meal)
      true
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_path
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, :description, :price, :address, :min_eaters, :max_eaters)
  end
end

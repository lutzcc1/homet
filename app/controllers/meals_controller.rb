class MealsController < ApplicationController
  def show
    @meal = Meal.find(params[:id])
  end
end

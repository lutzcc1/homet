class ReviewsController < ApplicationController
  def new
    @meal = Meal.find(params[:meal_id])
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @meal = Meal.find(params[:meal_id])
    @review.meal = @meal
    @review.user = current_user
    @review.save
    redirect_to bookings_path
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment, :meal_id, :user_id)
  end
end


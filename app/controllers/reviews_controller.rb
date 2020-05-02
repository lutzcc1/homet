class ReviewsController < ApplicationController
  def new
    @meal = Meal.find(params[:meal_id])
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @meal = Meal.find(params[:meal_id])
    @user = User.find(params[:user_id])
    @review.meal = @meal
    @review.user = @user
    @review.save
    redirect_to meal_path(@meal)
    #  redirect_to bookings? --> This would imply to add booking_id to review DB
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

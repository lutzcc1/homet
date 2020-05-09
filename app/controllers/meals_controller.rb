class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :home]
  before_action :set_meal, only: %i[edit update destroy show]

  def home
    if not params[:search].blank?
      @meals = policy_scope(Meal.where("name ilike?", "%#{params[:search]}%"))
      @query = params[:search]
    else
      @query = nil
      #@meals = policy_scope(Meal)
      @meals = Meal.geocoded
      @markers = @meals.map do |meal|
        {lat: meal.latitude,
         lng: meal.longitude,
         infoWindow: render_to_string(partial: "infowindow", locals: { meal: meal })
       }
      end
    end
    @meals = policy_scope(@meals)
  end


  def show
    @meal = Meal.find(params[:id])
    authorize @meal
    @meal_owner = @meal.user
    user_bookings = @meal.bookings.where(user: current_user)
    if user_bookings.empty? or user_bookings.last.date < Date.today
      @booking = Booking.new
    else
      @booking = @meal.bookings.where(user: current_user).last
    end

    @open_days = ""
    @days = @meal.open_days.length
    if @days == 1
      @open_days = "on #{@meal.open_days.first}s"
    elsif @days == 7
      @open_days = "everyday"
    elsif @meal.open_days.sort == ["Friday", "Monday", "Thursday", "Tuesday", "Wednesday"]
      @open_days = "on weekdays"
    elsif @meal.open_days.sort == ["Saturday", "Sunday"]
      @open_days = "on weekends"
    elsif @meal.open_days.length > 1
      @last_day = @meal.open_days.last
      @first_days = @meal.open_days.take(@days - 1) * "s, "
      @open_days = "on #{@first_days}s and #{@last_day}s"
    end
  end

  def offered
    @meals = policy_scope(current_user.meals.all)
  end

  def new
    @meal = Meal.new()
    authorize @meal
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    authorize @meal
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def update
    authorize @meal
    if @meal.update(meal_params)
      redirect_to meal_path(@meal)
    else
      render :edit
    end
  end

  def destroy
    authorize @meal
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
                                 open_days: [],
                                  photos: []
                                 )
  end
end


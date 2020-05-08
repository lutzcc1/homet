class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: [:home, :index, :offered, :eaters], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:home, :index, :offered, :eaters], unless: :skip_pundit?



  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,
    :email, :password])
    #in keys you list all the input you want to accept.
  end


  private

  def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

end

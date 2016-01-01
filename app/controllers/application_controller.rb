class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_mentor!, unless: :devise_controller?
  around_action :set_time_zone, if: :current_mentor

  def validate_admin!
    render_404 unless current_mentor.admin?
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def custom_error(model_instance, attribute_errors)
    ActiveModel::Errors.new(model_instance).tap do |error|
      attribute_errors.each do |attribute, error_message|
        error.set(attribute, error_message)
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def set_time_zone
    Time.use_zone(current_mentor.time_zone &block)
  end
end

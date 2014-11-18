class ApplicationController < ActionController::Base
  require 'csv'
  include Pundit
	before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  I18n.locale = :es

  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) << [:name, :credit_company_id]
	  end

    def user_not_authorized
      render plain: t(:unauthorized), status: 401
    end

end

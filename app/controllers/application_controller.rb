class ApplicationController < ActionController::Base
	around_action :switch_locale

	skip_before_action :verify_authenticity_token

	protect_from_forgery prepend: true

	before_action :configure_permitted_parameters, if: :devise_controller?

	def switch_locale(&action)
		locale = params[:locale] || I18n.default_locale
  		I18n.with_locale(locale, &action)
	end

	protected 

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:username])
	end		

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

end

class ApplicationController < ActionController::Base

	protect_from_forgery prepend: true

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected #db yml and this file

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:username])
	end		

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

end

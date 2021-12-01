class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:username])
	end		

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

end

class AdminController < ApplicationController
	before_action :set_user, :is_admin

	def index
		@users = User.all
	end


	def show
		@likes = Like.where(:user_id => params[:id], :liked => true)

		@user_c = User.find(params[:id])

		@posts = Post.where(user_id: @user_c.id)
	end


	private

	def set_user
		@user = User.find(current_user.id.to_i)
	end


	def is_admin
		if(!@user.admin)
			format.html {redirect_to '/', notice: "you dont have premissions"}
		end
	end
end

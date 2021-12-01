class LikesController < ApplicationController
	def create
		@like = Like.where(like_params)

		if @like[0]
			@liked = !@like.first.liked
			@like.update(:liked => @liked)
		else
			@like = Like.new(like_params)
			@like.save
		end

		redirect_to post_path(:id => params[:post_id])
	end

	private 

	def like_params
		params.permit(:post_id, :user_id)
	end


end

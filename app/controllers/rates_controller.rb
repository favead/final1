class RatesController < ApplicationController
	def create
		@rate = Rate.where(search_params)

		if @rate[0]
			@rate.update(update_params)
		else
			@rate = Rate.new(update_params)
			@rate.save
		end

		@post = Post.find(post_params)

		@post_rate = Rate.where(search_rate_post_params)

		@av_rate = average_rate(@post_rate)

		@post.update(:rate => @av_rate)

		redirect_to '/posts/'+@post.id.to_s
	end

	private 

	def search_params
		params.permit(:user_id,:post_id)
	end

	def search_rate_post_params
		params.permit(:post_id)
	end

	def update_params
		params.permit(:mark,:post_id,:user_id)
	end

	def post_params
		params[:id ] = params[:post_id]
		return params[:id]
	end

	def average_rate(rates)
		@t = 0
		rates.each do |rate|
			@t += rate.mark.to_i
		end
		return (@t/rates.count.to_i)
	end

end

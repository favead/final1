class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		@red_url = '/posts/'+params[:post_id].to_s
		respond_to do |format|
			if @comment.save
				format.html {redirect_to @red_url, notice: "article was succesly create"}
				format.json {render :show, status: :created, location: @post}
			end
		end
	end

	private

	def comment_params
		params.permit(:user_id,:post_id,:rich_content,:content)
	end
end

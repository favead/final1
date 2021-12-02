class PostsController < ApplicationController
	before_action :set_user, only: [:edit,:update,:destroy]
	before_action :set_post, only: [:show,:update,:destroy]

	def new
		@post = Post.new
	end

	def show
		@tags = @post.tags.split(' ')
		@comments = Comment.where(post_id: @id)
	end


	def create
		@post = Post.new(new_post_params)
				
		respond_to do |format|
			if @post.save
				format.html {redirect_to @post, notice: "article was succesly create"}
				format.json {render :show, status: :created, location: @article}
			end
		end
	end

	def edit
	end

	def update

		@post.update(update_post_params)

		redirect_to post_path(:id => @post.id)

	end

	def destroy
		@post.destroy
		redirect_to home_path(:id => @post.user_id)
	end

	private

		def new_post_params
			@content = params[:rich_content].to_s
			@content.split(/\<.*?\>/).join('')
			params[:content] = @content
			params.permit(:name,:content,:user_id,:tags,:published,:mark,:rich_content)
		end

		def update_post_params
			@content = params[:rich_content].to_s
			@content.split(/\<.*?\>/).join('')
			params[:content] = @content
			params.permit(:name,:content,:published,:tags,:mark,:rich_content)
		end

		def set_post
			@post = Post.find(params[:id].to_i)
		end

		def set_user
			@user = User.find(current_user.id.to_i)
		end
end

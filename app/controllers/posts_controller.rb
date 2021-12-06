class PostsController < ApplicationController
	before_action :set_user, only: [:edit,:new,:create]
	before_action :set_post, only: [:edit,:show,:destroy,:update]
	before_action :check_user, only: [:edit, :new]

	def new
		@post = Post.new
	end

	def show
		@av_rate = @post.rate
			
		@comments = Comment.where(post_id: @post.id)
	end


	def create
		@post = Post.new(new_post_params)
				

		respond_to do |format|
			if @post.save
				format.html {redirect_to home_path(:id => @user.id), notice: "post was succesly create"}
				format.json {render :show, status: :created, location: @post}
			end
		end
	end

	def edit
	end

	def update

		@post.update(update_post_params)

		redirect_to '/posts/'+@post.id.to_s

	end

	def destroy
		@post.destroy
		redirect_to home_path(:id => @post.user_id)
	end

	private

	def new_post_params
		params.permit(:name,:content,:published,:mark,:rich_content,:tagging,:user_id)
	end

	def update_post_params
		params.permit(:name,:content,:published,:mark,:rich_content,:tagging,:user_id)
	end

	def set_post
		@post = Post.find(params[:id].to_i)
	end

	def set_user
		@user = User.find(params[:user_id].to_i)
	end

	def check_user
		@user_r = User.find(current_user.id.to_i)
		if ((!(@user_r.admin)) && @user.id != @user_r.id)
			redirect_to home_path(:id => @user_r.id)
		end
	end

end

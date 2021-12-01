class HomesController < ApplicationController
	before_action :authenticate_user!, :set_user, only: [:show]


	def index
	end

	def find
		@search = PgSearch.multisearch(params[:value])
		@posts = []


		@search.each do |search|
			if(search.searchable_type == 'Post')
				@post = Post.find(search.searchable_id.to_i)
			elsif (search.searchable_type == 'Comment')
				@comment = Comment.find(search.searchable_id.to_i)
				@post = Post.find(@comment.post_id)
			end
			@posts.push(@post)
		end

		@message = false
		
		respond_to do |format|

			if @posts.count > 0
				format.json {render :json => @posts.to_json}
			else
				format.json {render :json => @message.to_json}
			end
		end
	end

	def show
		@likes = Like.where(:user_id => @user.id, :liked => true)

		@user = User.find(current_user.id)

		@new_post = '/posts/new'

		@posts = Post.where(user_id: @user.id)
	end

	private

	def set_user
		@user = User.find(current_user.id)
	end


end
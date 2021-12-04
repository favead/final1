class HomesController < ApplicationController
	before_action :authenticate_user!, :set_user, only: [:show]


	def index
		@posts_on_block = 5
		@posts_latest = Post.last(@posts_on_block)
		@posts_rated = Post.order("rate").reverse.last(@posts_on_block)
	end

	def find
		@search = PgSearch.multisearch(params[:value])
		@posts = []


		@search.each do |search|
			if(search.searchable_type == 'Post')
				@post = Post.find(search.searchable_id.to_i) || nil
			elsif (search.searchable_type == 'Comment')
				@comment = Comment.find(search.searchable_id.to_i) || nil
				@post = Post.find(@comment.post_id) || nil
			end
			@posts.push(@post)
		end

		@message = false
		
		respond_to do |format|

			if (@posts.first)
				format.json {render :json => @posts.to_json}
			else
				format.json {render :json => @message.to_json}
			end
		end
	end

	def show
		@likes = Like.where(:user_id => @user.id, :liked => true)

		@user = User.find(current_user.id) #to do чтобы считались лайки тебе и лайки от тебя

		@new_post = '/posts/new'

		@posts = Post.where(user_id: @user.id)

	end

	private

	def set_user
		@user = User.find(current_user.id)
	end

end
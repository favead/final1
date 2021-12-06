class TagsController < ApplicationController

	def show
		@post_tags = PostTag.where(:tag_id => params[:id])
		@tag = Tag.find(params[:id]).title
		@post_ids = @post_tags.map(&:post_id)
		@posts = Post.where(:id => @post_ids,:published => true)

	end

end

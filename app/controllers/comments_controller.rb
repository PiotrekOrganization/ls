class CommentsController < ApplicationController

	before_filter :authenticate_user!

	def create
		@comment = Comment.new(params[:comment])
		@comment.user = current_user
		@comment.save
		redirect_to root_path
	end

end
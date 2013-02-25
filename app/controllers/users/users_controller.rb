class Users::UsersController < ApplicationController

	before_filter :authenticate_user!

	def my_profile

	end

	def update
		@user = current_user
		@user.update_attributes(params[:user])
		@user.save
		redirect_to users_profile_path
	end

end
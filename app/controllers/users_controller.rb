class UsersController < ApplicationController

	def save_location
		long = params[:long]
		lat = params[:lat]
		if user_signed_in?
			current_user.latitude = lat
			current_user.longitude = long
			current_user.save
		else
			guest = Guest.find(@current_guest.id)
			guest.latitude = lat
			guest.longitude = long
			guest.save
			return
		end
		render :nothing => true, :status => 200, :content_type => 'text/html'
	end

end
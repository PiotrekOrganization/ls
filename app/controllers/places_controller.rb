class PlacesController < ApplicationController

	before_filter :authenticate_user!

	def list
		
	end

	def new
		@place = Place.new
	end

	def create
		@place = Place.new(params[:place])
		@place.user = current_user
		if !@place.save
			render new_subsciption_path
			return
		end
		@subscription = Subscription.new
		@subscription.place = @place
		@subscription.user = current_user
		@subscription.name = @place.name
		@subscription.save
		redirect_to root_path
	end

	def new_note
		@note = Note.new(params[:note])
		@note.user = current_user
		@note.save
		redirect_to place_wall_path(@note.place.slug) , :alert => "note created"
	end

end
class WallController < ApplicationController

	layout 'map', :only => "index"

	def index
		@notes = Note.all(:order => 'created_at DESC', :limit => 10)
		if user_signed_in?
			@new_note = Note.new
			@new_note.latitude = current_user.latitude
			@new_note.longitude = current_user.longitude
		end
	end

	def place
		@place = Place.where( :slug => params[:slug] ).first
		@notes = Note.where( :place_id => @place.id )
		if user_signed_in?
			@new_note = Note.new
			@new_note_form_url = new_place_note_path(@place)
			@new_note.place = @place
		end
	end

end

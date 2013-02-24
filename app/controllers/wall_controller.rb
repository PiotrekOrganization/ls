class WallController < ApplicationController

	def index
		@notes = Note.all(:order => 'created_at DESC', :limit => 10)
		if user_signed_in?
			@new_note = Note.new
			@new_note.latitude = current_user.latitude
			@new_note.longitude = current_user.longitude
		end
	end

end

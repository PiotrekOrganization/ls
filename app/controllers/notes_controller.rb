class NotesController < ApplicationController
	
	before_filter :authenticate_user!

	def new 
		@note = Note.new
	end

	def create 
		# this is a global wall note creator
		# for place note see places controller
		@note = Note.new(params[:note])
		@note.user = current_user
		if @note.latitude.nil? or @note.longitude.nil?
			@note.latitude = current_user.latitude
			@note.longitude = current_user.longitude
		end
		s = Geocoder.search([@note.latitude, @note.longitude])
		@note.address = s[0].formatted_address
		@note.save
		redirect_to root_path , :alert => "note created"
	end

	def get_local_notes
		@notes = Note.all
		render :json => @notes
	end

end

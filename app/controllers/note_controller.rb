class NoteController < ApplicationController
	def new 
		@note = Note.new
	end
	def create 
		@note = Note.new(params[:note])
		@note.user = current_user
		@note.latitude = current_user.latitude
		@note.longitude = current_user.longitude
		@note.save!
		redirect_to wall_index_path(@note) , :alert => "note created"
	rescue ActiveRecord::RecordInvalid
		render "new"
	end
end

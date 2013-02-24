class WallController < ApplicationController
	
	def index
		@notes = Note.all(:order => 'created_at DESC', :limit => 10)
	end

end

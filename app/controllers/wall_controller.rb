class WallController < ApplicationController
	def index
		@notes = Note.all
	end
end

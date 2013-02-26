class SubscriptionsController < ApplicationController

	before_filter :authenticate_user!

	def new
		@place = Place.new
		@places = Place.all
	end

end
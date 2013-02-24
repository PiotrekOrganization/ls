class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :get_location
  before_filter :current_guest

  #def get_location
  #	@current_location = request.location
  #end

  def current_guest
  	if session[:current_guest_id].nil?
  		@current_guest = Guest.create
  		session[:current_guest_id] = @current_guest.id
  	else
  		@current_guest = Guest.find(session[:current_guest_id])
  	end
  end

end

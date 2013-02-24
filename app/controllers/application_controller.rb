class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :get_location
  before_filter :current_guest

  #def get_location
  #	@current_location = request.location
  #end

  def current_guest

  	if user_signed_in? 
  		return 
  	end

  	begin
  		@current_guest = Guest.find(session[:current_guest])
 	rescue
 		@current_guest = Guest.new
  		@current_guest.ip_address = request.remote_ip
  		@current_guest.geocode
  		@current_guest.save
  		session[:current_guest] = @current_guest.id
 	end

  end

end

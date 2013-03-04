class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_guest
  before_filter :current_location

  #def get_location
  #	@current_location = request.location
  #end


  def current_location
    if user_signed_in?
      @lat = current_user.latitude
      @lng = current_user.longitude
    else
      @lat = @current_guest.latitude
      @lng = @current_guest.longitude
    end
  end

  def current_guest

  	if user_signed_in? and (current_user.updated_at < Time.now - 1.hour)
      #current_user.geocode
      #current_user.save
  	else

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

end

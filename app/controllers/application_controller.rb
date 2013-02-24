class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :get_location
  before_filter :current_guest
  before_filter :categories_initialization

  #def get_location
  #	@current_location = request.location
  #end

  def categories_initialization
    @categories = Category.all
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

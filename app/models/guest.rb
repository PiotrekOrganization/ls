class Guest < ActiveRecord::Base
	geocoded_by :ip_address
end

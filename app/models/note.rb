class Note < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user  
  	def address
  		[street, city, state].compact.join(', ')
	end
end

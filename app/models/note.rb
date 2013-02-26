class Note < ActiveRecord::Base

  	attr_accessible :content, :latitude, :longitude, :place_id
  	belongs_to :user
  	belongs_to :place
  	has_many :comments

end

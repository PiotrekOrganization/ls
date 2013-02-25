class Note < ActiveRecord::Base

  	attr_accessible :content, :latitude, :longitude
  	belongs_to :user
  	has_many :comments

end

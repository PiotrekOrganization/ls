class Note < ActiveRecord::Base
	default_scope order('created_at DESC')

  	attr_accessible :content, :latitude, :longitude, :place_id
  	belongs_to :user
  	belongs_to :place
  	has_many :comments

end

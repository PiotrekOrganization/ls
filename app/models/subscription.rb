class Subscription < ActiveRecord::Base
  attr_accessible :lat, :lng, :place_id, :round , :name
  belongs_to :user
  belongs_to :place
end

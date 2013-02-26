class Place < ActiveRecord::Base
  attr_accessible :name, :private_view, :private_write, :lat, :lng
  belongs_to :user
  has_many :subscriptions
  has_many :notes
end

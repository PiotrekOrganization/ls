class Place < ActiveRecord::Base
  attr_accessible :name, :private_view, :private_write
  belongs_to :user
  has_many :subscriptions
end

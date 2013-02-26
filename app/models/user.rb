class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :notes
  has_many :comments
  geocoded_by :current_sign_in_ip
  # attr_accessible :title, :body

  has_many :sent_messages , :class_name => "Message" , :foreign_key => "sender_id"
  has_many :recived_messages , :class_name => "Message" , :foreign_key => "receiver_id"
  has_many :places
  has_many :subscriptions

  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :big => "600x400", :medium => "100x100>", :thumb => "42x42>" }, :default_url => "/assets/images/avatars/:style/default.jpg"

  def location_name
    begin
      s = Geocoder.search("#{self[:latitude]}, #{self[:longitude]}")
      s[0].formatted_address
    rescue
      'Location not available'
    end
  end

end

class Comment < ActiveRecord::Base
	default_scope order('created_at DESC')
	attr_accessible :content, :note_id, :user_id
	belongs_to :user
	belongs_to :note
end

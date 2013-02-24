class Messages::MessagesController < ApplicationController
	
	def sent_messages
		@sent_messages = current_user.sent_messages		
	end

	def recived_messages
		@recived_messages = current_user.recived_messages
	end

	def post_reply
		
	end
end

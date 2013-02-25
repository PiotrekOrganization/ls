class Messages::MessagesController < ApplicationController
	before_filter :authenticate_user!
	def sent_messages
		@sent_messages = current_user.sent_messages		
	end

	def recived_messages
		@recived_messages = current_user.recived_messages.reverse
	end

	def post_reply
		@post_reply = Message.new			
		@post_reply.receiver = Note.find(params[:id]).user	
	end
	def create
		@message = Message.new(params[:message])
		@message.sender = current_user		
		@message.save!
		redirect_to messages_inbox_path

	end
end

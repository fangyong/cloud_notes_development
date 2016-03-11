class RepliesController < ApplicationController
	before_filter :authenticate_user!

	def index
		replies = Reply.all
		respond_to do |format|
			format.html { render :index }
			format.json { render :json => { :status => 1, :data => replies } }
		end
	end

	def create
		begin
			user = current_user
			comment = Comment.find(params[:comment_id])
			reply = {}
			reply["text"] = params[:text]
			r = Reply.new reply
			if r.save
				user.replies << r
				comment.replies << r
			end
			respond_to do |format|
				format.html { render :index }
				format.json { render :json => { :status => 1, :data => r } }
			end
		rescue Exception => e
			respond_to do |format|
				format.html { render :index }
				format.json { render :json => { :status => 0, :error => e.to_s } }
			end
		end
	end
end
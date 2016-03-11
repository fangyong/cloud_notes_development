class CommentsController < ApplicationController
	before_filter :authenticate_user!

	def index
		comments = Comment.all
		respond_to do |format|
			format.html { render :index }
			format.json { render :json => { :status => 1, :data => comments } }
		end
	end

	def create
		begin
			user = current_user
			comment = {}
			comment["text"] = params[:text]
			c = Comment.new comment
			if c.save
				user.comments << c
			end
			respond_to do |format|
				format.html { render :index }
				format.json { render :json => { :status => 1, :data => c } }
			end
		rescue Exception => e
			respond_to do |format|
				format.html { render :index }
				format.json { render :json => { :status => 0, :error => e.to_s } }
			end
		end
	end

end
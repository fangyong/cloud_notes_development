class UsersController < ApplicationController
	before_filter :authenticate_user!

	def index
		users = User.all
		# users = users.any_of("name like fang")
		respond_to do |format|
			format.html { render :index }
			format.json { render :json => { :status => 1, :data => users } }
		end
	end

end
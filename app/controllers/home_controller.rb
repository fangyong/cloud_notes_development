class HomeController < ApplicationController

	before_filter :authenticate_user_from_token!
	skip_before_filter :authenticate_user!, :all

	def index
		respond_to do |format|
			format.html{ render :index }
		end
	end

end
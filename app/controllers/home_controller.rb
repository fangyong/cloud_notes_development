class HomeController < ApplicationController

	def index
		respond_to do |format|
			format.html{ redirect_to cloud_files_path }
		end
	end

end
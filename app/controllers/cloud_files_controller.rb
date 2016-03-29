class CloudFilesController < ApplicationController

	skip_before_filter :verify_authenticity_token, :all
 	skip_before_filter :authenticate_user!, :all

 	include UuidTool

	def index
		begin
			user = User.find(params[:user_id])
			unless user
				raise "User was not found!"
			end
			files = user.files
			respond_to do |format|
				format.json { render :json => { :status => 1, :data => files } }
			end
		rescue Exception => e 
			respond_to do |format|
				format.json { render :json => { :status => 0, :err_msg => e.to_s } }
			end
		end
	end

	def upload
		begin
			user = User.find(params[:user_id])
			unless user
				raise "User was not found!"
			end
			file = params[:file]
	        path = "" 
	        if !file.original_filename.empty?  
	            filename = get_uuid
	            extension = file.original_filename[/\.[^\.]+$/]
	            path = "files/#{filename}#{extension}"
	            File.open(path, "wb") do |f|  
	                f.write(file.read)  
	            end  
	        end
	        path_real = "http://52.35.19.25/files/#{filename}#{extension}"
	        file_hash = {}
	        file_hash["name"] = filename
	        file_hash["path"] = path_real
	        f = CloudFile.new file_hash
	        if f.save
	        	user.cloud_files << f
	        end
	        respond_to do |format|
	            format.json  { render :json => { :status => 1, :path => path_real} }
	        end
    	rescue Exception => e
    		@error = e.to_s
			respond_to do |format|
	        	format.html  { render :index }
	        	format.json  { render :json => { :status => 0, :err_msg => @error } }
	      	end
    	end
    	
	end
end
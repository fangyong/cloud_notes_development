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
	        path_real = "https://s3-us-west-2.amazonaws.com/cloudfilestorage/#{filename}#{extension}"
	        file_hash = {}
	        file_hash["name"] = filename
	        file_hash["path"] = path_real
	        client = Aws::S3::Client.new(access_key_id: "AKIAIQGIA5QGLJ5MMYSA", secret_access_key: "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")
	        resource = Aws::S3::Resource.new(client: client)
	        if resource.bucket("cloudfilestorage").object("#{filename}#{extension}").upload_file("files/#{filename}#{extension}")
		        f = CloudFile.new file_hash
		        if f.save
		        	user.cloud_files << f
		        end
		        respond_to do |format|
		            format.json  { render :json => { :status => 1, :path => path_real} }
		        end
		    else
		    	raise "Service sync error!"
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
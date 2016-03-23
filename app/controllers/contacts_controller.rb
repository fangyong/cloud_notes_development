class ContactsController < ApplicationController

	skip_before_filter :verify_authenticity_token, :all
 	skip_before_filter :authenticate_user!, :all

	def index
		begin
			user = User.find(params[:user_id])
			unless user
				raise "User was not found!"
			end
			contacts = user.contacts
			respond_to do |format|
				format.json { render :json => { :status => 1, :data => contacts } }
			end
		rescue Exception => e 
			respond_to do |format|
				format.json { render :json => { :status => 0, :err_msg => e.to_s } }
			end
		end
	end

	def sync
		begin
			json = request.body.read
			request_content = JSON.parse(json)
			unless request_content.class == {}.class
				raise "Contact format error!"
			end
			user = User.find(request_content["user_id"])
			unless user
				raise "User was not found!"
			end
			contacts = request_content["contacts"]
			
			contacts.each do |contact|
				con_f_model = user.contacts.where(:name => contact["name"]).first
				if con_f_model
					if con_f_model.phone_number != contact["phone_number"] 
						con_f_model.phone_number = contact["phone_number"]
						con_f_model.save
					end
					next
				end
				c = Contact.new contact
				if c.save
					user.contacts << c
				end
			end 
			respond_to do |format|
				format.json { render :json => { :status => 1, :data => user.contacts } }
			end
		rescue Exception => e
			respond_to do |format|
				format.json { render :json => { :status => 0, :err_msg => e.to_s } }
			end
		end
	end
end
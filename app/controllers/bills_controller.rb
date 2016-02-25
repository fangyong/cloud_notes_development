class BillsController < ApplicationController

	def index
		begin
			@bills = Bill.page(params[:page]).per(params[:size]).asc(:_id)
			respond_to do |format|
				format.json{ render :json => { :status => 1, :data => @bills } }
			end
		rescue Exception => e
			@error = e.to_s
			respond_to do |format|
				format.json{ render :json => { :status => 0, :err_msg => @error } }
			end
		end
	end

end
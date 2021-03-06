class Users::SessionsController < Devise::SessionsController

	def create
		##验证邮箱是否存在
		user = User.find_for_database_authentication(:email => params[:user][:email])
		return render json: { error: { status: - 1 } } unless user

		# respond_to do |format|
			#验证密码是否正确
			if user.valid_password?(params[:user][:password])
				sign_in("user", user)
				user.ensure_authentication_token
				user.save
				# format.json { 
					render json: { token:user.authentication_token, user_id: user.id } 
				# }
			else
				# format.json {
				render json: { error: { status: - 1 } } 
			# }
			end
		# end
	end
  
	#注销就是更换用户token
	def destroy
		puts "destroy"
		puts "#{current_user}"
		current_user.authentication_token = Devise.friendly_token
		sign_out(current_user)
		render json: { success: true }
	end
end
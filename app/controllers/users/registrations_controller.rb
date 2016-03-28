class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(user_params)
    # respond_to do |format|
      if @user.save
        # format.json { render json: { success: true, token:@user.authentication_token, user_id:@user.id }}
        render json: { success: true, token:@user.authentication_token, user_id:@user.id }
      end
    # end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
end
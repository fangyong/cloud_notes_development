class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

   # 因为用作API，所以关闭防CSRF不然会出问题
  protect_from_forgery with: :null_session

  private

  # 获取http:/xxx.com/books.json?token=aMUj5kiyLbmZdjpr_iAu
  # 判断token的值是否存在，若存在且能在User表中找到相应的，就登录此用户
  def authenticate_user_from_token!
    puts "authenticate"
    token = params[:token].presence
    puts "token is #{token}"
    user = token && User.find_by(authentication_token:token.to_s)
    puts "user is #{user}"
    if user
      sign_in user, store: false
    end
  end

end

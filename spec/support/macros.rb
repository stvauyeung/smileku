def sign_in_user(user=nil)
	user.present? ? session[:user_id] = user.id : session[:user_id] = Fabricate(:user).id
end

def clear_current_user
	session[:user_id] = nil
end
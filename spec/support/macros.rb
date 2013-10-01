def sign_in_user(user=nil)
	user.present? ? session[:user_id] = user.id : session[:user_id] = Fabricate(:user).id
end

def clear_current_user
	session[:user_id] = nil
end

# feature spec macro
def login_user(username, password)
	visit login_path
	fill_in 'username', with: username
	fill_in 'password', with: password
	click_button 'Sign in'
end
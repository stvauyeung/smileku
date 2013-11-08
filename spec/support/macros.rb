def sign_in_user(user=nil)
	user.present? ? session[:user_token] = user.token : session[:user_token] = Fabricate(:user).token
end

def clear_current_user
	session[:user_token] = nil
end

# feature spec macro
def login_user(username, password)
	visit login_path
	fill_in 'username', with: username
	fill_in 'password', with: password
	click_button 'Sign in'
end
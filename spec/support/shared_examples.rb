shared_examples "require_login" do
	it "redirects to login path for non signed in user" do
		clear_current_user
		action
		response.should redirect_to login_path
	end
	it "it displays flash error for non signed in user" do
		clear_current_user
		action
		expect(flash[:error]).to be_present
	end
end
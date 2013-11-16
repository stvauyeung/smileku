require 'spec_helper'

feature "user creates a new story" do
	before do
		Fabricate(:user, username: 'bobby', password: 'password')
		login_user('bobby', 'password')
		visit new_story_path
	end

	scenario "user creates a valid story" do
		fill_in 'Title', with: "A title example"
		fill_in 'Description', with: "Some description of a story"
		fill_in 'Body', with: "Body of the story"
		attach_file 'Upload a Cover', 'spec/fixtures/mrec1.jpg'
		click_button 'Publish'
		page.should have_content "Body of the story"
	end
	scenario "user creates an invalid story" do
		fill_in 'Description', with: "Some description of a story"
		fill_in 'Body', with: "Body of the story"
		attach_file 'Upload a Cover', 'spec/fixtures/mrec1.jpg'
		click_button 'Publish'
		page.should have_content "Whoops!"
	end
end
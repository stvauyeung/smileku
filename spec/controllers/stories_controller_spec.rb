require 'spec_helper'

describe StoriesController do
	describe "GET new" do
		it_behaves_like "require_login" do
			let(:action) { get :new }
		end
		it "creates a new story" do
			sign_in_user
			get :new
			assigns(:story).should be_an_instance_of(Story)
			assigns(:story).should be_new_record
		end
		it "creates a new ku" do
			sign_in_user
			get :new
			assigns(:ku).should be_an_instance_of(Ku)
			assigns(:ku).should be_new_record
		end
	end

	describe "POST create" do
		it_behaves_like "require_login" do
			let(:action) { post :create }
		end
		context "successful story creation" do
			let(:bob) { Fabricate(:user) }
			before do
				sign_in_user(bob)
				post :create, story: Fabricate.attributes_for(:story), ku: Fabricate.attributes_for(:ku)
			end

			it "should save a new story" do
				expect(Story.count).to eq(1)
			end
			it "should save a new ku"
			it "should set the story to belong to current user"
			it "should set the ku to belong to the current user"
			it "should set the ku to belong to the story"
			it "should rediret to story path"
		end
		context "failed story creation"
	end
end
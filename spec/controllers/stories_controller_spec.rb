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
				file = File.open(file_path('public/tmp/mrec1.jpg'))
				post :create, story: Fabricate.attributes_for(:story), ku: Fabricate.attributes_for(:ku)
			end

			it "should save a new story" do
				expect(Story.count).to eq(1)
			end
			it "should save a new ku" do
				expect(Ku.count).to eq(1)
			end
			it "should set the story to belong to current user" do
				expect(Story.last.user).to eq(bob)
			end
			it "should set the ku to belong to the current user" do
				expect(Ku.last.user).to eq(bob)
			end
			it "should set the ku to belong to the story" do
				expect(Story.last.kus).to eq([Ku.last])
			end
			it "should redirect to story path" do
				response.should redirect_to story_path(Story.last)
			end
		end

		context "failed story creation" do
			let(:bob) { Fabricate(:user) }
			before { sign_in_user(bob) }

			it "does not create a new story" do
				post :create, story: Fabricate.attributes_for(:invalid_story), ku: Fabricate.attributes_for(:ku)
				expect(Story.count).to eq(0)
			end
			it "does not create a new ku" do
				post :create, story: Fabricate.attributes_for(:story), ku: Fabricate.attributes_for(:invalid_ku)
				expect(Ku.count).to eq(0)
			end
			it "renders the new template" do
				post :create, story: Fabricate.attributes_for(:story), ku: Fabricate.attributes_for(:invalid_ku)
				response.should render_template(:new)
			end
		end
	end
end
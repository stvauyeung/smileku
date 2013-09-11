require 'spec_helper'

describe User do
	it { should have_many(:stories) }
	it { should have_many(:kus) }
	it { should have_secure_password }
	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:username) }
	it { should validate_uniqueness_of(:email) }
end
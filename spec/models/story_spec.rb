require 'spec_helper'

describe Story do
	it { should belong_to(:user) }
	it { should have_many(:kus) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:large_cover_url) }
end
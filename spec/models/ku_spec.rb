require 'spec_helper'

describe Ku do
	it { should belong_to(:story) }
	it { should belong_to(:user) }
	it { should have_many(:children).class_name('Ku') }
	it { should belong_to(:parent).class_name('Ku') }
	it { should validate_presence_of(:body) }
end
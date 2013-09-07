require 'spec_helper'

describe Story do
	it { should belong_to(:user) }
	it { should have_many(:kus) }
end
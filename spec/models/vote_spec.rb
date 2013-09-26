require 'spec_helper'

describe Vote do
	it { should belong_to(:voteable) }
end
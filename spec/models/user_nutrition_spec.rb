require File.join(File.dirname(__FILE__), "/../spec_helper")
# You might notice +/- 5 days here and there. The accuracy of many of the life stage classifications is sporadic because of Ruby Date year determination. Since this is not really a big deal I chose to take less accuracy as it really doesn't matter.

describe User do
  it { should have_many :entry_matches }
  it { should respond_to :report_for }
end
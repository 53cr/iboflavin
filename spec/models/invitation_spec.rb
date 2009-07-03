require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Invitation do
  specify { should have_one :recipient }
  specify { should belong_to :sender }
  it "should have named_scope for requests" do
    Invitation.should have_named_scope :requests
    i = Invitation.create(:recipient_email => 'my@address.com')
    Invitation.requests.each do |inv|
      inv.sender.should be nil
    end
  end
end

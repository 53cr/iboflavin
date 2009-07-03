class Invitation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  validates_presence_of :recipient_email

  validates_format_of :recipient_email, :with => RFC822::EmailAddress, :on => :create, :message => "is invalid"
  validate :recipient_is_not_registered
  #validate :sender_has_invitations, :if => :sender

  before_create :generate_token
  #before_create :decrement_sender_count

  named_scope :requests, :conditions => {:sender_id => nil }

  private

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

end

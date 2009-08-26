class User < ActiveRecord::Base
  TYPES = [:user,:administrator]
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" },
                              :path   => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
                              :url    => "/system/:class/:attachment/:id/:style/:basename.:extension"

  validates_presence_of :username
  validates_uniqueness_of :username

  comma do
    username
    email
    phone
  end

  acts_as_authentic do |config|
    config.perishable_token_valid_for = 1.hour
    config.login_field= :email
  end

  # simple state machine to handle user confirmation
  state_machine :initial => :unconfirmed do
    event :confirm! do
      transition :unconfirmed => :confirmed
    end

    state :confirmed
    event :unconfirm! do
      transition :confirmed => :unconfirmed
    end
  end
end

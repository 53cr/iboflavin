require 'nutrition'
require 'nutrition/requirements'

#TODO: add columns: lifestyle
class User < ActiveRecord::Base

  # Invitation Stuff
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  attr_accessible :invitation_token
  
  # uncomment if you want to restrict signup  - see railscast on betas
  if INVITATION_REQUIRED_FOR_SIGNUP
    validates_presence_of :invitation, :on => :create, :message => "can't be blank. We're sorry we aren't ready for our big debut yet!"
  end
  
  # End Invitation Stuff

  acts_as_authentic

  has_many :entry_matches
  has_many :entries
  has_many :goals
  attr_accessible :birthday, :sex, :pregnant, :lactating,
                  :password_confirmation, :password, :age, :login, :email, :lifestyle

  #TODO We don't want to force users to register with this. Run a custom validation that validates only if they're defined.

  validates_inclusion_of :sex, :in => [:male, 'male', :female, 'female', nil, '']
  validates_inclusion_of :lifestyle, :in => ['sedentary', 'active', 'low active', nil, '']
  validate :age_between_0_and_999
  validates_uniqueness_of :twitter_screen_name, :oauth_token, :oauth_secret, :allow_nil => true

  def nutritional_requirements
    @nutr_reqs ||= Nutrition::Requirements.for(self)
  end

  def start_of_day
    t = Time.now.utc.beginning_of_day + time_zone + 1.day
    2.times{ (t -= 1.day) if (t > Time.now.utc) }
    return t
  end

  def entries_today
    Entry.find(:all, :conditions =>
               ["user_id = ? AND created_at >= ?",
                self.id,
                self.start_of_day],
               :order => 'id DESC')
  end

  def entry_matches_today
    EntryMatch.find(:all, :conditions =>
                    ["user_id = ? AND created_at >= ?",
                     self.id,
                     self.start_of_day],
                    :order => 'id DESC')
  end

  def rdi_for(nutrient)
    nutritional_requirements.for(nutrient)
  end

  def age
    if self.birthday
      ((Date.today - self.birthday) / 365).to_f
    end
  end

  def birthday
    if self[:birthday]
      self[:birthday].to_date
    end
  end

  def filled_in?
    sidebar_prompt_off or (self[:birthday] and self[:sex] and self[:lifestyle])
  end

  def infant?; (0...1) === self.age; end

  def child?; (1...9) === self.age; end

  def male?; self.sex.to_sym == :male; end
  def female?; self.sex.to_sym == :female; end

  def report_for(opts = {:date => lambda {Date.today}.call })
  end

  private
  def age_between_0_and_999
    unless (0..999) === self.age or self.age == nil
      errors.add(:birthday, "should make you from 0 to 999 years old")
    end
  end
end


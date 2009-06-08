class User < ActiveRecord::Base

  acts_as_authentic

  has_many :entry_matches
  attr_accessible :birthday, :sex, :pregnant, :lactating,
                  :password_confirmation, :password, :age, :login, :email

  #TODO We don't want to force users to register with this. Run a custom validation that validates only if they're defined.

  validates_inclusion_of :sex, :in => [:male, 'male', :female, 'female', nil, '']
  validate :age_between_0_and_999
  validates_uniqueness_of :twitter_screen_name, :oauth_token, :oauth_secret, :allow_nil => true
  
  def nutritional_requirements
    Nutrition
    @nutr_reqs ||= Nutrition::Requirements.for(self)
  end
  
  def rdi_for(nutrient)
    nutritional_requirements.for(nutrient)
  end
  
  def age
    if self.birthday
      ((Date.today - self.birthday) / 365).to_f
    end
  end

  def age=(age)
  end

  def birthday
    if self[:birthday]
      self[:birthday].to_date
    end
  end

  def infant?
    (0...1) === self.age
  end

  def child?
    (1...9) === self.age
  end
  
  def report_for(opts = {:date => lambda {Date.today}.call })
  end

  private
  def age_between_0_and_999
    unless (0..999) === self.age or self.age == nil
      errors.add(:birthday, "should make you from 0 to 999 years old")
    end
  end
end


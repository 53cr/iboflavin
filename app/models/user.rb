class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :birthday, :sex, :pregnant, :lactating
  
  validates_presence_of :birthday

  validates_presence_of :sex  
  validates_inclusion_of :sex, :in => [:male,:female]

  validate :age_between_0_and_999
  
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

  private 
  def age_between_0_and_999
    unless (0..999) === self.age 
      errors.add(:birthday, "should make you from 0 to 999 years old")
    end
  end
end

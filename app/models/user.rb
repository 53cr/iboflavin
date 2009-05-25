class User < ActiveRecord::Base

  before_create :check_twitter

  validates_presence_of :age
  validates_numericality_of :age, :less_than_or_equal_to => 999, :greater_than_or_equal_to => 0

  validates_uniqueness_of :twitter_account
  
  validates_presence_of :sex  
  validates_inclusion_of :sex, :in => ['male','female']

  def infant?
    (0...1) === age
  end
  
  def child?
    (1...9) === age
  end
  
  acts_as_authentic do |c|
  end

  def check_twitter

  end
end

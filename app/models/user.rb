class User < ActiveRecord::Base
  include Clearance::User

  validates_presence_of :age
  validates_numericality_of :age, :less_than_or_equal_to => 999, :greater_than_or_equal_to => 0

  validates_presence_of :sex  
  validates_inclusion_of :sex, :in => ['male','female']

  def infant?
    (0...1) === age
  end
  
  def child?
    (1...9) === age
  end

end

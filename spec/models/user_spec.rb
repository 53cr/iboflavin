require File.join(File.dirname(__FILE__), "/../spec_helper")

describe User do
  before(:each) do
    @user = User.new( :age => 22, :sex => :male )
  end
  
  it { should respond_to :sex }
  it { should respond_to :age }
  it { should respond_to :birthday }
  it { should respond_to :pregnant? }
  it { should respond_to :lactating? }
  it { should respond_to :child? }
  it { should respond_to :infant? }
  
  it { should validate_presence_of :age}
  it { should validate_numericality_of :age}
  it { should validate_presence_of :sex}
  it "should be either male or female" do  
    @user.sex = :male
    @user.should be_valid
    
    @user.sex = :female
    @user.should be_valid
    
    @user.sex = :goorplon
    @user.should be_invalid
  end
  
  it "should give proper age for birthday" do
    pending
    @user.birthday = Date.new(1987,02,18)
    @user.age.should be(22)
  end
  it "should validate birthday"

  it "must be from 0 to 999 years old" do
    invalid_ages = [-500, -1, 1000, 9999]
    invalid_ages.each do |invalid_age|
      @user.age = invalid_age
      @user.should be_invalid
    end
    
    valid_ages = [0, 1.0/4, 900, 999, *(1..99).to_a]
    valid_ages.each do |valid_age|
      @user.age = valid_age
      @user.should be_valid
    end
  end

  it "should be an infant if < 1 year old" do
    infant_ages = [0, 0.25, 0.50, 0.99]
    infant_ages.each do |age| 
      @user.age =  age
      @user.save
      puts @user.inspect
      @user.should be_infant
    end
    non_infant_ages = [1, 5, 19, 56]
    non_infant_ages.each do |age| 
      @user.age =  age
      @user.save
      @user.should_not be_infant
    end
  end
  
  it "should be a child if >= 1 year old and < 9" do
    child_ages = [1, 2, 3, 4, 5, 6, 7, 8.0, 8.99]
    child_ages.each do |age| 
      @user.age =  age
      @user.should be_child
    end
    non_child_ages = [0.5, 9, 19, 56]
    non_child_ages.each do |age| 
      @user.age =  age
      @user.should_not be_child
    end
  end
end

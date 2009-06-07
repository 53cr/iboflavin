require File.join(File.dirname(__FILE__), "/../spec_helper")
# You might notice +/- 5 days here and there. The accuracy of many of the life stage classifications is sporadic because of Ruby Date year determination. Since this is not really a big deal I chose to take less accuracy as it really doesn't matter.

describe User do
  VALID_ATTR = { :login => "ryan", :email => "ryan@neufeld.ca", :password => "unicorns", :password_confirmation=> "unicorns"}
  before(:each) do
    @user = User.create( VALID_ATTR )
  end
  subject {@user}
  
  # General specs
  it { should respond_to :sex }
  it { should respond_to :age }
  it { should respond_to :birthday }
  it { should respond_to :pregnant? }
  it { should respond_to :lactating? }
  it { should respond_to :child? }
  it { should respond_to :infant? }
  
  # Sex related specs
  it "should be either male or female" do  
    @user.sex = :male
    @user.should be_valid
    
    @user.sex = :female
    @user.should be_valid
    
    @user.sex = :goorplon
    @user.should be_invalid
  end
  
  # Birthday related specs
  it "should validate birthday" do
    @user.birthday = "frankenstein"
    @user.birthday.should be nil
    
    @user.birthday = 22.years.ago
    @user.should be_valid
    
    @user.birthday = nil
    @user.should be_valid
  end
  
  it "should give proper age for birthday" do
    @user.birthday = 22.years.ago
    @user.age.to_i.should be(22)
  end

  # Age related specs
  it "must be from 0 to 999 years old" do
    invalid_ages = [-500, -1, 1000, 9999]
    invalid_ages.each do |invalid_age|
      @user.birthday = invalid_age.years.ago
      @user.should be_invalid
    end
    
    valid_ages = [0.01, 1, 900, 998, *(1..99).to_a]
    valid_ages.each do |valid_age|
      @user.birthday = (valid_age * 365).days.ago
      @user.should be_valid
    end
  end

  it "should be an infant if < 1 year old" do
    infant_ages = [1, 125, 250, 360]
    infant_ages.each do |age|
      @user.birthday =  age.days.ago
      @user.save
      @user.should be_infant
    end
    non_infant_ages = [1, 5, 19, 56]
    non_infant_ages.each do |age| 
      @user.birthday =  age.years.ago - 5.days
      @user.save
      @user.should_not be_infant
    end
  end
  
  it "should be a child if >= 1 year old and < 9" do
    child_ages = [1, 2, 3, 4, 5, 6, 7, 8, 8.99]
    @user.birthday =  1.years.ago - 5.days
    @user.should be_child
    @user.birthday =  5.years.ago
    @user.should be_child
    @user.birthday =  9.years.ago + 5.days
    @user.should be_child
    
    @user.birthday =  1.years.ago + 5.days
    @user.should_not be_child
    @user.birthday =  9.years.ago
    @user.should_not be_child
    @user.birthday =  19.years.ago
    @user.should_not be_child
  end
end

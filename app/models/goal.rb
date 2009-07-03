class Goal < ActiveRecord::Base

  belongs_to :user
  belongs_to :nutrient

  def amount
    read_attribute(:amount) || self.user.rdi_for(self.nutrient)
  end

end

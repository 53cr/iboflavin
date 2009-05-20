class FoodItem < ActiveRecord::Base
  
  belongs_to :food_group

  has_many :food_item_nutrients
  has_many :nutrients, :through => :food_item_nutrients


  define_index do

    indexes name

  end


  def self.awesome_search(text, unit, amount)

    # THIS NEEDS MAJOR OPTIMIZATION. LIKE, SO BAD.
    
    # PHASE 1a: Previous results submitted by this user with the exact same text
#     x = EntryMatch.find(:all, :conditions => {:search => text, :user_id => 1})
#     x.map(&:food_item_id)


#    return self.search(text)

    return self.first
    
  end
  
end

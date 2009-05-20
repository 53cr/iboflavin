module Nutrition
  class Requirements
    def self.for(user)
      if user.pregnant or user.lactating
        
      elsif user.child or user.infant
        
      else
        if user.male
          
        elsif user.female
          
        end
      end
    end
    
    class Error < RuntimeError; end
    UNITS = {
      #Vitamins
      :vit_a => :microgram,
      :vit_c => :milligram,
      :vit_d=> :microgram, 
      :vit_e=> :milligram, 
      :vit_k=> :microgram, 
      :thiamin => :milligram, 
      :riboflavin => :milligram, 
      :niacin => :milligram, 
      :vit_b6 => :milligram, 
      :folate => :microgram, 
      :vit_b12 => :microgram, 
      :pantothenic => :milligram, 
      :biotin => :microgram, 
      :choline => :milligram,
      #Elements
      :calcium => :milligram,
      :chromium => :microgram, 
      :copper => :microgram, 
      :fluoride => :milligram, 
      :iodine => :microgram, 
      :iron => :milligram, 
      :magnesium => :milligram, 
      :manganese => :milligram, 
      :molybdenum => :microgram, 
      :phosphorus => :milligram, 
      :selenium => :microgram, 
      :zinc => :milligram, 
      :potassium => :gram, 
      :sodium => :gram, 
      :chloride => :gram,
    }
    
    def initialize(nutrients={})
      if !nutrients.keys.all? {|key| UNITS.keys.any? {|master| master == key}}
        raise Nutrition::Requirements::Error.new "An imported vitamin has the wrong key"
      end
      
      @_data = nutrients
    end
  
  
  end
end
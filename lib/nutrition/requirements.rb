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
      :vit_d => :microgram, 
      :vit_e => :milligram, 
      :vit_k => :microgram, 
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
      if !UNITS.includes_all? nutrients.keys
        raise Nutrition::Requirements::Error.new "An imported vitamin has the wrong key"
      end
      if !nutrients.includes_all? UNITS.keys
        raise Nutrition::Requirements::Error.new "The imported vitamins are missing a key"
      end
      
      @_data = nutrients
    end
    
    def for(nutrient)
      vitamin = @_data[nutrient]
      return { :value => vitamin, :unit => UNITS[nutrient] }
    end
    def self.valid_nutrients
      UNITS.keys
    end
  end
end
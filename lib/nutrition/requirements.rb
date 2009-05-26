module Nutrition
  class Requirements
    def self.for(user)
      if user.infant?
        DATA[:infant].with_keys_as_ranges(user.age)
      elsif user.child?
        DATA[:child].with_keys_as_ranges(user.age)
      elsif user.lactating?
        DATA[:lactating].with_keys_as_ranges(user.age)
      elsif user.pregnant?
        DATA[:pregnant].with_keys_as_ranges(user.age)
      else
        DATA[user.sex].with_keys_as_ranges(user.age)
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

class Hash
  def with_keys_as_ranges(number)
    self.each_key { |key| if key === number; return self[key]; end}
  end
end
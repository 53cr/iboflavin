require 'enumerable'

module Nutrition
  class Requirements
    def self.for(user)
      if user.nil? or (user and (user.age.nil?))
        DATA[:male].with_keys_as_ranges(25)
      elsif user.infant?
        DATA[:infant].with_keys_as_ranges(user.age)
      elsif user.child?
        DATA[:child].with_keys_as_ranges(user.age)
      elsif user.lactating?
        DATA[:lactating].with_keys_as_ranges(user.age)
      elsif user.pregnant?
        DATA[:pregnant].with_keys_as_ranges(user.age)
      else
        DATA[user.sex.to_sym || :male].with_keys_as_ranges(user.age)
      end
    end
    
    UNITS = {
      #Vitamins
      :vit_a => :mcg_RAE,
      :vit_c => :mg,
      :vit_d => :IU,
      :vit_e => :mg, 
      :vit_k => :mcg, 
      :thiamin => :mg, 
      :riboflavin => :mg, 
      :niacin => :mg, 
      :vit_b6 => :mg, 
      :folate => :mcg_DFE, 
      :vit_b12 => :mcg, 
      :pantothenic => :mg, 
      :biotin => :mcg, 
      :choline => :mg,
      #Elements
      :calcium => :mg,
      :chromium => :mcg, 
      :copper => :mg, 
      :fluoride => :mcg, 
      :iodine => :mcg, 
      :iron => :mg, 
      :magnesium => :mg, 
      :manganese => :mg, 
      :molybdenum => :mcg, 
      :phosphorus => :mg, 
      :selenium => :mcg, 
      :zinc => :mg, 
      :potassium => :mg, 
      :sodium => :mg, 
      :chloride => :g,
    }
    NUTRIENTS = [:vit_a, :vit_c, :vit_d, :vit_e, :vit_k, :thiamin, :riboflavin, :niacin, :vit_b6, :folate, :vit_b12, :pantothenic, :biotin,  :choline,
    #Elements
    :calcium, :chromium,  :copper,  :fluoride,  :iodine,  :iron,  :magnesium,  :manganese,  :molybdenum,  :phosphorus,  :selenium,  :zinc,  :potassium,  :sodium,  :chloride]
    NUTRIENT_IDS_TO_NUTRIENT = {
      320 => :vit_a,
      401 => :vit_c,
      324 => :vit_d,
      323 => :vit_e,
      430 => :vit_k,
      404 => :thiamin,
      405 => :riboflavin,
      406 => :niacin,
      415 => :vit_b6,
      435 => :folate,
      418 => :vit_b12,
      410 => :pantothenic,
      # ?? => :biotin,
      421 => :choline,
      #Elements
      301 => :calcium,
      # ?? => :chromium,
      312 => :copper,
      313 => :fluoride,
      # ?? => :iodine,
      303 => :iron,
      304 => :magnesium,
      315 => :manganese,
      # ?? => :molybdenum,
      305 => :phosphorus,
      317 => :selenium,
      309 => :zinc,
      306 => :potassium,
      307 => :sodium
      # ?? => :chloride,
    }
    def initialize(nutrients={})
      if !NUTRIENTS.includes_all? nutrients.keys 
        error_msg = "An imported vitamin has the wrong key"
        RAILS_DEFAULT_LOGGER.error error_msg
        raise error_msg if defined?(TESTING_GOING_ON)
        return nil
      end
      if !nutrients.includes_all? NUTRIENTS
        error_msg = "The imported vitamins are missing a key"
        RAILS_DEFAULT_LOGGER.error error_msg
        raise error_msg if defined?(TESTING_GOING_ON)
        return nil
      end
      
      @_data = nutrients
    end
    
    def for(nutrient)
      if nutrient.kind_of? Nutrient
        nutrient = NUTRIENT_IDS_TO_NUTRIENT[nutrient.id]
      end
      return @_data[nutrient]
    end
    
    def self.valid_nutrients
      NUTRIENTS
    end
  end
end



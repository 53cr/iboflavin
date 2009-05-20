module Nutrition
  class Requirements
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
    
    def initialize(params={})
      
    end
  
  
  end
end
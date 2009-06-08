module Nutrition
  class EnergyRequirement
    MALE = {
      (2...4) => { :sedentary => 1100, :low_active => 1350, :active => 1500 },
      (4...6) => { :sedentary => 1250, :low_active =>	1450, :active => 1650 },
      (6...8) => { :sedentary => 1400, :low_active =>	1600, :active => 1800 },
      (8...10) => { :sedentary => 1500, :low_active =>	1750, :active => 2000 },
      (10...12) => { :sedentary => 1700, :low_active =>	2000, :active => 2300 },
      (12...14) => { :sedentary => 1900, :low_active =>	2250, :active => 2600 },
      (14...17) => { :sedentary => 2300, :low_active =>	2700, :active => 3100 },
      (17...19) => { :sedentary => 2450, :low_active =>	2900, :active => 3300 },
      (19...31) => { :sedentary => 2500, :low_active =>	2700, :active => 3000 },
      (31...51) => { :sedentary => 2350, :low_active =>	2600, :active => 2900 },
      (51...71) => { :sedentary => 2150, :low_active =>	2350, :active => 2650 },
      (71...999) => { :sedentary => 2000, :low_active =>	2200, :active => 2500 }
    }
    FEMALE = {
      (2...4) => { :sedentary => 1100, :low_active =>	1250, :active => 1400 },
      (4...6) => { :sedentary => 1200, :low_active =>	1350, :active => 1500 },
      (6...8) => { :sedentary => 1300, :low_active =>	1500, :active => 1700 },
      (8...10) => { :sedentary => 1400, :low_active =>	1600, :active => 1850 },
      (10...12) => { :sedentary => 1500, :low_active =>	1800, :active => 2050 },
      (12...14) => { :sedentary => 1700, :low_active =>	2000, :active => 2250 },
      (14...17) => { :sedentary => 1750, :low_active =>	2100, :active => 2350 },
      (17...19) => { :sedentary => 1750, :low_active =>	2100, :active => 2400 },
      (19...31) => { :sedentary => 1900, :low_active =>	2100, :active => 2350 },
      (31...51) => { :sedentary => 1800, :low_active =>	2000, :active => 2250 },
      (51...71) => { :sedentary => 1650, :low_active =>	1850, :active => 2100 },
      (71...999) => { :sedentary => 1550, :low_active =>	1750, :active => 2000 }
    }
    def self.for(user) 
      
    end
  end
end
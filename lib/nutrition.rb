#Vitamins
# :vit_a, :vit_c, :vit_d, :vit_e, :vit_k, :thiamin, :riboflavin, :niacin, :vit_b6, :folate, :vit_b12, :pantothenic, :biotin, :choline
#Elements
#:calcium, :chromium, :copper, :fluoride, :iodine, :iron, :magnesium, :manganese, :molybdenum, :phosphorus, :selenium, :zinc, :potassium, :sodium, :chloride
require "nutrition/requirements"
module Nutrition  
  def self.raw_data
    DATA
  end
  DATA = {
    :infant => {
      (0...7.0/12) => Nutrition::Requirements.new({
        :vit_a=>400, :vit_c=>40, :vit_d=>5, :vit_e=>4, :vit_k=>2.0,
        :thiamin=>0.2, :riboflavin=>0.3, :niacin=>2, :vit_b6=>0.1,
        :folate=>65, :vit_b12=>0.4, :pantothenic=>1.7, :biotin=>5,
        :choline=>125,
        :calcium=>210, :chromium=>0.2, :copper=>200, :fluoride=>0.01,
        :iodine=>110, :iron=>0.27, :magnesium=>30, :manganese=>0.003,
        :molybdenum=>2, :phosphorus=>100, :selenium=>15, :zinc=>2,
        :potassium=>0.4, :sodium=>0.12, :chloride=>0.18
        }),
      (7.0/12...1) => Nutrition::Requirements.new({
        :vit_a=>500, :vit_c=>50, :vit_d=>5, :vit_e=>5, :vit_k=>2.5,
        :thiamin=>0.3, :riboflavin=>0.4, :niacin=>4, :vit_b6=>0.3,
        :folate=>80, :vit_b12=>0.5, :pantothenic=>1.8, :biotin=>6,
        :choline=>150,
        :calcium=>270, :chromium=>5.5, :copper=>220, :fluoride=>0.5,
        :iodine=>130, :iron=>11, :magnesium=>75, :manganese=>0.6,
        :molybdenum=>3, :phosphorus=>275, :selenium=>20, :zinc=>3,
        :potassium=>0.7, :sodium=>0.37, :chloride=>0.57        
        }),
      },
    :child => {
      (1...4) => Nutrition::Requirements.new({
        :vit_a=>300, :vit_c=>15, :vit_d=>5, :vit_e=>6, :vit_k=>30,
        :thiamin=>0.5, :riboflavin=>0.5, :niacin=>6, :vit_b6=>0.5,
        :folate=>150, :vit_b12=>0.9, :pantothenic=>2, :biotin=>8,
        :choline=>200,
        :calcium=>500, :chromium=>11, :copper=>340, :fluoride=>0.7,
        :iodine=>90, :iron=>7, :magnesium=>80, :manganese=>1.2,
        :molybdenum=>17, :phosphorus=>460, :selenium=>20, :zinc=>3,
        :potassium=>3.0, :sodium=>1.0, :chloride=>1.5
        }),
      (4...9) => Nutrition::Requirements.new({
        :vit_a=>400, :vit_c=>25, :vit_d=>5, :vit_e=>7, :vit_k=>55,
         :thiamin=>0.6, :riboflavin=>0.6, :niacin=>8, :vit_b6=>0.6,
         :folate=>200, :vit_b12=>1.2, :pantothenic=>3, :biotin=>12,
         :choline=>250,
         :calcium=>800, :chromium=>15, :copper=>440, :fluoride=>1,
         :iodine=>90, :iron=>10, :magnesium=>130, :manganese=>1.5,
         :molybdenum=>22, :phosphorus=>500, :selenium=>30, :zinc=>5,
         :potassium=>3.8, :sodium=>1.2, :chloride=>1.9
        }),
    },
    :male => {
      (9...14) => Nutrition::Requirements.new({
        :vit_a=>600, :vit_c=>45, :vit_d=>5, :vit_e=>11, :vit_k=>60,
         :thiamin=>0.9, :riboflavin=>0.9, :niacin=>12, :vit_b6=>1.0,
         :folate=>300, :vit_b12=>1.8, :pantothenic=>4, :biotin=>20,
         :choline=>375,
         :calcium=>1_300, :chromium=>25, :copper=>700, :fluoride=>2,
         :iodine=>120, :iron=>8, :magnesium=>240, :manganese=>1.9,
         :molybdenum=>34, :phosphorus=>1_250, :selenium=>40, :zinc=>8,
         :potassium=>4.5, :sodium=>1.5, :chloride=>2.3
        }),
      (14...19) => Nutrition::Requirements.new({
        :vit_a=>900, :vit_c=>75, :vit_d=>5, :vit_e=>15, :vit_k=>75,
         :thiamin=>1.2, :riboflavin=>1.3, :niacin=>16, :vit_b6=>1.3,
         :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>25,
         :choline=>550,
         :calcium=>1_300, :chromium=>35, :copper=>890, :fluoride=>3,
         :iodine=>150, :iron=>11, :magnesium=>410, :manganese=>2.2,
         :molybdenum=>43, :phosphorus=>1_250, :selenium=>55, :zinc=>11,
         :potassium=>4.7, :sodium=>1.5, :chloride=>2.3
        }),
      (19...30) => Nutrition::Requirements.new({
        :vit_a=>900, :vit_c=>90, :vit_d=>5, :vit_e=>15, :vit_k=>120,
         :thiamin=>1.2, :riboflavin=>1.3, :niacin=>16, :vit_b6=>1.3,
         :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
         :choline=>550,
         :calcium=>1_000, :chromium=>35, :copper=>900, :fluoride=>4,
         :iodine=>150, :iron=>8, :magnesium=>400, :manganese=>2.3,
         :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>11,
         :potassium=>4.7, :sodium=>1.5, :chloride=>2.3
        }),
      (31...51) => Nutrition::Requirements.new({
        :vit_a=>900, :vit_c=>90, :vit_d=>5, :vit_e=>15, :vit_k=>120,
         :thiamin=>1.2, :riboflavin=>1.3, :niacin=>16, :vit_b6=>1.3,
         :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
         :choline=>550,
         :calcium=>1_000, :chromium=>35, :copper=>900, :fluoride=>4,
         :iodine=>150, :iron=>8, :magnesium=>420, :manganese=>2.3,
         :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>11,
         :potassium=>4.7, :sodium=>1.5, :chloride=>2.3
        }),
      (51...70) => Nutrition::Requirements.new({
        :vit_a=>900, :vit_c=>90, :vit_d=>10, :vit_e=>15, :vit_k=>120,
         :thiamin=>1.2, :riboflavin=>1.3, :niacin=>16, :vit_b6=>1.7,
         :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
         :choline=>550,
         :calcium=>1_200, :chromium=>30, :copper=>900, :fluoride=>4,
         :iodine=>150, :iron=>8, :magnesium=>420, :manganese=>2.3,
         :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>11,
         :potassium=>4.7, :sodium=>1.3, :chloride=>2.0
        }),
      (70...999) => Nutrition::Requirements.new({
        :vit_a=>900, :vit_c=>90, :vit_d=>15, :vit_e=>15, :vit_k=>120,
         :thiamin=>1.2, :riboflavin=>1.3, :niacin=>16, :vit_b6=>1.7,
         :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
         :choline=>550,
         :calcium=>1_200, :chromium=>30, :copper=>900, :fluoride=>4,
         :iodine=>150, :iron=>8, :magnesium=>420, :manganese=>2.3,
         :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>11,
         :potassium=>4.7, :sodium=>1.2, :chloride=>1.8
        }),
    },
    :female => {
      (9...14) => Nutrition::Requirements.new({
        :vit_a=>600, :vit_c=>45, :vit_d=>5, :vit_e=>11, :vit_k=>60,
        :thiamin=>0.9, :riboflavin=>0.9, :niacin=>12, :vit_b6=>1.0,
        :folate=>300, :vit_b12=>1.8, :pantothenic=>4, :biotin=>20,
        :choline=>375,
        :calcium=>1_300, :chromium=>21, :copper=>700, :fluoride=>2,
        :iodine=>120, :iron=>8, :magnesium=>240, :manganese=>1.6,
        :molybdenum=>34, :phosphorus=>1_250, :selenium=>40, :zinc=>8,
        :potassium=>4.5, :sodium=>1.5, :chloride=>2.3
        
        }),
      (14...19) => Nutrition::Requirements.new({
        :vit_a=>700, :vit_c=>65, :vit_d=>5, :vit_e=>15, :vit_k=>75,
        :thiamin=>1.0, :riboflavin=>1.0, :niacin=>14, :vit_b6=>1.2,
        :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>25,
        :choline=>400,
        :calcium=>1_300, :chromium=>24, :copper=>890, :fluoride=>3,
        :iodine=>150, :iron=>15, :magnesium=>360, :manganese=>1.6,
        :molybdenum=>43, :phosphorus=>1_250, :selenium=>55, :zinc=>9,
        :potassium=>4.7, :sodium=>1.5, :chloride=>2.3

        }),
      (19...30) => Nutrition::Requirements.new({
        :vit_a=>700, :vit_c=>75, :vit_d=>5, :vit_e=>15, :vit_k=>90,
        :thiamin=>1.1, :riboflavin=>1.1, :niacin=>14, :vit_b6=>1.3,
        :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
        :choline=>425,
        :calcium=>1_000, :chromium=>25, :copper=>900, :fluoride=>3,
        :iodine=>150, :iron=>18, :magnesium=>310, :manganese=>1.8,
        :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>8,
        :potassium=>4.7, :sodium=>1.5, :chloride=>2.3

        }),
      (31...51) => Nutrition::Requirements.new({
        :vit_a=>700, :vit_c=>75, :vit_d=>5, :vit_e=>15, :vit_k=>90,
        :thiamin=>1.1, :riboflavin=>1.1, :niacin=>14, :vit_b6=>1.3,
        :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
        :choline=>425,
        :calcium=>1_000, :chromium=>25, :copper=>900, :fluoride=>3,
        :iodine=>150, :iron=>18, :magnesium=>320, :manganese=>1.8,
        :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>8,
        :potassium=>4.7, :sodium=>1.5, :chloride=>2.3

        }),
      (51...70) => Nutrition::Requirements.new({
        :vit_a=>700, :vit_c=>75, :vit_d=>10, :vit_e=>15, :vit_k=>90,
        :thiamin=>1.1, :riboflavin=>1.1, :niacin=>14, :vit_b6=>1.5,
        :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
        :choline=>425,
        :calcium=>1_200, :chromium=>20, :copper=>900, :fluoride=>3,
        :iodine=>150, :iron=>8, :magnesium=>320, :manganese=>1.8,
        :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>8,
        :potassium=>4.7, :sodium=>1.3, :chloride=>2.0

        }),
      (70...999) => Nutrition::Requirements.new({
        :vit_a=>700, :vit_c=>75, :vit_d=>15, :vit_e=>15, :vit_k=>90,
        :thiamin=>1.1, :riboflavin=>1.1, :niacin=>14, :vit_b6=>1.5,
        :folate=>400, :vit_b12=>2.4, :pantothenic=>5, :biotin=>30,
        :choline=>425,
        :calcium=>1_200, :chromium=>20, :copper=>900, :fluoride=>3,
        :iodine=>150, :iron=>8, :magnesium=>320, :manganese=>1.8,
        :molybdenum=>45, :phosphorus=>700, :selenium=>55, :zinc=>8,
        :potassium=>4.7, :sodium=>1.2, :chloride=>1.8

        }),
    },
    :pregnant => {
      (14...19) => Nutrition::Requirements.new({
        :vit_a=>750, :vit_c=>80, :vit_d=>5, :vit_e=>15, :vit_k=>75,
        :thiamin=>1.4, :riboflavin=>1.4, :niacin=>18, :vit_b6=>1.9,
        :folate=>600, :vit_b12=>2.6, :pantothenic=>6, :biotin=>30,
        :choline=>450,
        :calcium=>1_300, :chromium=>29, :copper=>1_000, :fluoride=>3,
        :iodine=>220, :iron=>27, :magnesium=>400, :manganese=>2.0,
        :molybdenum=>50, :phosphorus=>1_250, :selenium=>60, :zinc=>12,
        :potassium=>4.7, :sodium=>1.5, :chloride=>2.3
        }),
      (19...31) => Nutrition::Requirements.new({
        :vit_a=>770, :vit_c=>85, :vit_d=>5, :vit_e=>15, :vit_k=>90,
        :thiamin=>1.4, :riboflavin=>1.4, :niacin=>18, :vit_b6=>1.9,
        :folate=>600, :vit_b12=>2.6, :pantothenic=>6, :biotin=>30,
        :choline=>450,
        :calcium=>1_000, :chromium=>30, :copper=>1_000, :fluoride=>3,
        :iodine=>220, :iron=>27, :magnesium=>350, :manganese=>2.0,
        :molybdenum=>50, :phosphorus=>700, :selenium=>60, :zinc=>11,
        :potassium=>4.7, :sodium=>1.5, :chloride=>2.3
        }),
      (31...50) => Nutrition::Requirements.new({
        :vit_a=>770, :vit_c=>85, :vit_d=>5, :vit_e=>15, :vit_k=>90,
        :thiamin=>1.4, :riboflavin=>1.4, :niacin=>18, :vit_b6=>1.9,
        :folate=>600, :vit_b12=>2.6, :pantothenic=>6, :biotin=>30,
        :choline=>450,
        :calcium=>1_000, :chromium=>30, :copper=>1_000, :fluoride=>3,
        :iodine=>220, :iron=>27, :magnesium=>360, :manganese=>2.0,
        :molybdenum=>50, :phosphorus=>700, :selenium=>60, :zinc=>11,
        :potassium=>4.7, :sodium=>1.5, :chloride=>2.3
        }),
    },
    :lactating => {
      (14...19) => Nutrition::Requirements.new({
        :vit_a=>1_200, :vit_c=>115, :vit_d=>5, :vit_e=>19, :vit_k=>75,
        :thiamin=>1.4, :riboflavin=>1.6, :niacin=>17, :vit_b6=>2.0,
        :folate=>500, :vit_b12=>2.8, :pantothenic=>7, :biotin=>35,
        :choline=>550,
        :calcium=>1_300, :chromium=>44, :copper=>1_300, :fluoride=>3,
        :iodine=>290, :iron=>10, :magnesium=>360, :manganese=>2.6,
        :molybdenum=>50, :phosphorus=>1_250, :selenium=>70, :zinc=>13,
        :potassium=>5.1, :sodium=>1.5, :chloride=>2.3
        }),
      (19...31) => Nutrition::Requirements.new({
        :vit_a=>1_300, :vit_c=>120, :vit_d=>5, :vit_e=>19, :vit_k=>90,
        :thiamin=>1.4, :riboflavin=>1.6, :niacin=>17, :vit_b6=>2.0,
        :folate=>500, :vit_b12=>2.8, :pantothenic=>7, :biotin=>35,
        :choline=>550,
        :calcium=>1_000, :chromium=>45, :copper=>1_300, :fluoride=>3,
        :iodine=>290, :iron=>9, :magnesium=>310, :manganese=>2.6,
        :molybdenum=>50, :phosphorus=>700, :selenium=>70, :zinc=>12,
        :potassium=>5.1, :sodium=>1.5, :chloride=>2.3
        }),
      (31...50) => Nutrition::Requirements.new({
        :vit_a=>1_300, :vit_c=>120, :vit_d=>5, :vit_e=>19, :vit_k=>90,
        :thiamin=>1.4, :riboflavin=>1.6, :niacin=>17, :vit_b6=>2.0,
        :folate=>500, :vit_b12=>2.8, :pantothenic=>7, :biotin=>35,
        :choline=>550,
        :calcium=>1_000, :chromium=>45, :copper=>1_300, :fluoride=>3,
        :iodine=>290, :iron=>9, :magnesium=>320, :manganese=>2.6,
        :molybdenum=>50, :phosphorus=>700, :selenium=>70, :zinc=>12,
        :potassium=>5.1, :sodium=>1.5, :chloride=>2.3
        })
    }
  }
  
end

# Little script I used to translate entries to hash
# def omg(w)
#   w.map {|number| number.gsub(/[^\d\.]/,'')}
#   k = [:calcium, :chromium, :copper, :fluoride, :iodine, :iron, :magnesium, :manganese, :molybde 
#   hash = {}
#   w.each.with_index do |value, i|
#     hash[k[i]] = value
#   end
#   puts hash
# end

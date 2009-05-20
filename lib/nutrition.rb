# WIP

#Vitamins
# :vit_a, :vit_c, :vit_d, :vit_e, :vit_k, :thiamin, :riboflavin, :niacin, :vit_b6, :folate, :vit_b12, :pantothenic, :biotin, :choline
#Elements
#:calcium, :chromium, :copper, :fluoride, :iodine, :iron, :magnesium, :manganese, :molybdenum, :phosphorus, :selenium, :zinc, :potassium, :sodium, :chloride
module Nutrition
  DATA = {
    :infant => {
      (0...7.0/12) => Nutrition::Requirements.new({
        
      }),
      (7.0/12...1) => Nutrition::Requirements.new({
        
      }),
    },
    :child => {
      (1...4) => Nutrition::Requirements.new({

        }),
      (4...9) => Nutrition::Requirements.new({

        }),
    },
    :male => {
      (9...14) => Nutrition::Requirements.new({

        }),
      (14...19) => Nutrition::Requirements.new({

        }),
      (19...30) => Nutrition::Requirements.new({

        }),
      (31...51) => Nutrition::Requirements.new({

        }),
      (51...70) => Nutrition::Requirements.new({

        }),
      (70...999) => Nutrition::Requirements.new({

        }),
    },
    :female => {
      (9...14) => Nutrition::Requirements.new({

        }),
      (14...19) => Nutrition::Requirements.new({

        }),
      (19...30) => Nutrition::Requirements.new({

        }),
      (31...51) => Nutrition::Requirements.new({

        }),
      (51...70) => Nutrition::Requirements.new({

        }),
      (70...999) => Nutrition::Requirements.new({

        }),
    },
    :pregnant => {
      (14...19) => Nutrition::Requirements.new({

        }),
      (19...31) => Nutrition::Requirements.new({

        }),
      (31...50) => Nutrition::Requirements.new({

        }),
    },
    :lactating => {
      (14...19) => Nutrition::Requirements.new({

        }),
      (19...31) => Nutrition::Requirements.new({

        }),
      (31...50) => Nutrition::Requirements.new({

        }),
    }
  }
end
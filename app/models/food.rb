class Food
  include MongoMapper::Document

  key :name,       String
  key :food_group, String
  key :nutrients,  Hash
  
  many :weights
  
end

class Weight
  include MongoMapper::EmbeddedDocument

  key :description, String
  key :grams,       Float

end

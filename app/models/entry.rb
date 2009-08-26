class Entry
  include MongoMapper::Document

  key :user_id, Integer
  key :text,    String
  key :food_id, String
  key :amount,  Float

end

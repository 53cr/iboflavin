require 'fastercsv'

class ImportFoodItemNutrients < ActiveRecord::Migration
  def self.up
    fname = File.join(File.dirname(__FILE__),"../usda_sr21/NUT_DATA.txt")
    csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
    csv.each do |row|
      f=FoodItemNutrient.new(:food_item_id => row[0],
                             :nutrient_id => row[1],
                             :amount => row[2])
      f.save!
    end
  end

  def self.down
  end
end

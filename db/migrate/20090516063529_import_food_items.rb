require 'fastercsv'
require 'progress'

class ImportFoodItems < ActiveRecord::Migration
  def self.up
    fname = File.join(File.dirname(__FILE__),"../usda_sr21/FOOD_DES.txt")
    csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
    csv.each do |row|
      f=FoodItem.new(:food_group_id => row[1],
                     :long_desc => row[2],
                     :short_desc => row[3],
                     :common_names => row[4],
                     :manufacturer_name => row[5],
                     :scientific_name => row[9])
      f.id=row[0]
      f.save!
    end
  end

  def self.down
  end
end

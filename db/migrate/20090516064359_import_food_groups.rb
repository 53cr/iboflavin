require 'fastercsv'

class ImportFoodGroups < ActiveRecord::Migration
  def self.up
    fname = File.join(File.dirname(__FILE__),"../usda_sr21/FD_GROUP.txt")
    csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
    csv.each do |row|
      f=FoodGroup.new(:name => row[1])
      f.id=row[0]
      f.save!
    end
  end

  def self.down
  end
end

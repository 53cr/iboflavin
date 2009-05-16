require 'fastercsv'

class ImportNutrients < ActiveRecord::Migration
  def self.up
    fname = File.join(File.dirname(__FILE__),"../usda_sr21/NUTR_DEF.txt")
    csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
    csv.each do |row|
      f=Nutrient.new(:unit => row[1],
                     :tagname => row[2],
                     :description => row[3])
      f.id=row[0]
      f.save!
    end
  end

  def self.down
  end
end

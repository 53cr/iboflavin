#!/usr/bin/env ruby

require 'fastercsv'

task :loadusda do 
  
  food_items = {}
  food_groups = {}
  nutrients = {}
  food_item_nutrients = {}
  weights = {}
  
  puts "Importing Food Groups..."
  fname = "FD_GROUP.txt"
  csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
  csv.each do |row|
    food_groups[row[0]] = row[1]
  end
  
  puts "Importing Food Items..."
  fname = "FOOD_DES.txt"
  csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
  csv.each do |row|
    food_items[row[0]] = Food.new({:food_group => food_groups[row[1]], :name => row[2]})
  end
  
  puts "Importing Nutrients..."
  fname = "NUTR_DEF.txt"
  csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
  csv.each do |row|
    nutrients[row[0]] = {:unit => row[1], :tagname => row[2], :description => row[3]}
  end
  
  puts "Importing Food Item Nutrients..."
  fname = "NUT_DATA.txt"
  csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
  csv.each do |row|
    r2f = row[2].to_f
    unless r2f == 0.0
      food_items[row[0]].nutrients ||= {}
      food_items[row[0]].nutrients.merge!({nutrients[row[1]][:tagname] => r2f})
    end
  end
  
  puts "Importing Weights..."
  fname = "WEIGHT.txt"
  csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
  csv.each do |row|
    food_items[row[0]] << Weight.new({:amount => row[2].to_i, :description => row[3], :grams => row[4].to_f})
  end

  food_items.each do |food_item_id, food_item|
    food_items.map(&:save)
  end

end

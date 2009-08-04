#!/usr/bin/env ruby

# Here we go...
require 'rubygems'
require 'fastercsv'
require 'mongo'


db = XGen::Mongo::Driver::Mongo::new("localhost").db("iboflavin")
foods = db.collection("foods")

food_items = {}
food_groups = {}
nutrients = {}
food_item_nutrients = {}
weights = {}


puts "Importing Food Items..."
fname = "FOOD_DES.txt"
csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
csv.each do |row|
  food_items[row[0]] = {:food_group => row[1], :name => row[2]}
end

puts "Importing Food Groups..."
fname = "FD_GROUP.txt"
csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
csv.each do |row|
  food_groups[row[0]] = {:name => row[1]}
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
  food_item_nutrients[row[0]] ||= {}
  r2f = row[2].to_f
  unless r2f == 0.0
    food_item_nutrients[row[0]].merge!({nutrients[row[1]][:tagname] => r2f})
  end
end

puts "Importing Weights..."
fname = "WEIGHT.txt"
csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
csv.each do |row|
  weights[row[0]] ||= []
  weights[row[0]] << {:amount => row[2].to_i, :description => row[3], :grams => row[4].to_f}
end


food_items.each do |food_item_id, food_item|
  
  food_item[:food_group] = food_groups[food_item[:food_group]][:name]
  food_item[:weights] = weights[food_item_id]
  food_item[:nutrients] = food_item_nutrients[food_item_id]
  
  puts "#{food_item_id} : #{food_item[:nutrients].size rescue 0}"
  foods.insert(food_item)

  
end



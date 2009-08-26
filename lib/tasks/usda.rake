#!/usr/bin/env ruby

require 'fastercsv'

namespace :usda do 
  task :load => :environment do 

    get_csv = lambda do |fname|
      FasterCSV.new(File.read(File.join(RAILS_ROOT,'db','usda_sr21',fname)),
                    :col_sep => '^',
                    :quote_char => '~')
    end
    
    food_items = {}
    food_groups = {}
    nutrients = {}
    food_item_nutrients = {}
    weights = {}
    
    puts "Importing Food Groups..."
    fname = "FD_GROUP.txt"
    get_csv["FD_GROUP.txt"].each do |row|
      food_groups[row[0]] = row[1]
    end
    
    puts "Importing Food Items..."
    get_csv["FOOD_DES.txt"].each do |row|
      food_items[row[0]] = Food.new({:food_group => food_groups[row[1]], :name => row[2]})
    end
    
    puts "Importing Nutrients..."
    get_csv["NUTR_DEF.txt"].each do |row|
      nutrients[row[0]] = {:unit => row[1], :tagname => row[2], :description => row[3]}
    end
    
    puts "Importing Food Item Nutrients..."
    get_csv["NUT_DATA.txt"].each do |row|
      r2f = row[2].to_f
      unless r2f == 0.0
        food_items[row[0]].nutrients ||= {}
        food_items[row[0]].nutrients.merge!({nutrients[row[1]][:tagname] => r2f})
      end
    end
    
    puts "Importing Weights..."
    get_csv["WEIGHT.txt"].each do |row|
      food_items[row[0]].weights << Weight.new({:amount => row[2].to_i, :description => row[3], :grams => row[4].to_f})
    end

    puts "Saving Foods..."
    food_items.each do |food_item_id, food_item|
      food_item.save
    end
    
  end
end

require 'fastercsv'

task 'usda:import' => ['usda:import:food_items','usda:import:food_groups','usda:import:nutrients','usda:import:food_item_nutrients', 'usda:import:weights']

namespace :usda do
  namespace :import do
  
    task :food_items => :environment do
      puts "Importing Food Items..."
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/FOOD_DES.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      FoodItem.transaction do
        csv.each do |row|
          id = row[0]
          row.each {|item| if item; item.gsub!('"','""'); end}
          FoodItem.connection.execute "insert into food_items (id,food_group_id,name,common_names,manufacturer_name) values(#{row[0]},#{row[1]},\"#{row[2]}\", \"#{row[4]}\", \"#{row[5]}\")"
        end
      end
    end
  
    task :food_groups => :environment do
      puts "Importing Food Groups..."
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/FD_GROUP.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      FoodGroup.transaction do
        csv.each do |row|
          FoodGroup.connection.execute "insert into food_groups (id,name) values(#{row[0]},\"#{row[1]}\")"
        end
      end
    end
  
    task :nutrients => :environment do
      puts "Importing Nutrients..."
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/NUTR_DEF.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      Nutrient.transaction do
        csv.each do |row|
          Nutrient.connection.execute "insert into nutrients (id, unit, tagname, description) values (#{row[0]},\"#{row[1]}\",\"#{row[2]}\",\"#{row[3]}\")"
        end
      end
    end
  
    task :food_item_nutrients => :environment do
      puts "Importing Food Item Nutrients... ~1.5 minutes"
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/NUT_DATA.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      FoodItemNutrient.transaction do
        csv.each do |row|
          FoodItemNutrient.connection.execute "insert into food_item_nutrients (food_item_id, nutrient_id, amount) values(#{row[0]},#{row[1]},#{row[2]})"
        end
      end
    end

    task :weights => :environment do
      puts "Importing Weights"
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/WEIGHT.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      Weight.transaction do 
        csv.each do |row|
          Weight.connection.execute "insert into weights (food_item_id,amount,description,grams) values(#{row[0]},#{row[2]},\"#{row[3].gsub('"','""')}\",#{row[4]})"
        end
      end
    end
    
  end
end  

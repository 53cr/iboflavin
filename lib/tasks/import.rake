require 'fastercsv'

task 'usda:import' => ['usda:import:food_items','usda:import:food_groups','usda:import:nutrients','usda:import:food_item_nutrients', 'usda:import:weights']

namespace :usda do
  namespace :import do
  
    task :food_items => :environment do
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/FOOD_DES.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      FoodItem.transaction do
        csv.each do |row|
          f=FoodItem.new(:food_group_id => row[1],
                         :name => row[2],
                         :common_names => row[4],
                         :manufacturer_name => row[5])
          f.id=row[0]
          f.save!
        end
      end
    end
  
    task :food_groups => :environment do
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/FD_GROUP.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      FoodGroup.transaction do
        csv.each do |row|
          f=FoodGroup.new(:name => row[1])
          f.id=row[0]
          f.save!
        end
      end
    end
  
    task :nutrients => :environment do
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/NUTR_DEF.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      Nutrient.transaction do
        csv.each do |row|
          f=Nutrient.new(:unit => row[1],
                         :tagname => row[2],
                         :description => row[3])
          f.id=row[0]
          f.save!
        end
      end
    end
  
    task :food_item_nutrients => :environment do
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/NUT_DATA.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      FoodItemNutrient.transaction do
        csv.each do |row|
          f=FoodItemNutrient.new(:food_item_id => row[0],
                                 :nutrient_id => row[1],
                                 :amount => row[2])
          f.save!
        end
      end
    end

    task :weights => :environment do
      fname = File.join(RAILS_ROOT,"/db/usda_sr21/WEIGHT.txt")
      csv = FasterCSV.new(File.read(fname),:col_sep => '^', :quote_char => '~')
      Weight.transaction do 
        csv.each do |row|
          f=Weight.new(:food_item_id => row[0],
                                 :amount => row[2],
                                 :description => row[3],
                                 :grams => row[4])
          f.save!
        end
      end
    end
    
  end
end  

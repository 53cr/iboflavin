#!/usr/bin/env rb
#-*- ruby -*-

def floz(floz)
  return floz.to_f*0.0295735296
end

def cup(cup)
  return cup.to_f*0.250
end

def cubinch(ci)
  return ci.to_f*0.016387064
end
  
def tbsp(tbsp)
  return tbsp.to_f*0.015
end

def tsp(tsp)
  return tsp.to_f*0.005
end

def htsp(htsp)
  return htsp.to_f*0.008
end

def volume(desc)
  case desc
  when /^(NLEA )?serving$/i
    return nil
  when /medium serving/i
    return nil
  when /serving (packet|medium)/i
    return nil
  when /\d+ ?oz/
    return nil # solid ounces
  when /^oz/
    return nil # solid ounces
  when /cubic inch/
    return cubinch(1)
  when /serving ([\d\.]+) fl oz/
    return floz($1)
  when /^fl oz/
    return floz(1)
  when /[ \(]([\d\.]+) fl oz/
    return floz($1)
  when /(\d+) heaping tsp/
    return htsp($1)
  when /^cup/
    return 0.250
  when /^(tsp|teaspoon)( rounded)?/
    return tsp(1)
  when / ([\d\.]+) cup/
    return cup($1)
  when / ([\d\.]+) tsp/
    return tsp($1)
  when /1\/2 cup/
    return 0.125
  when "serving 1/ 2 cup"
    return 0.125
  when "serving 1/3 cup"
    return 0.250/3
  when /serving \((\d+) tbsp\)/i
    return tbsp($1)
  when /^(tbsp|tablespoon)/
    return tbsp(1)
  when /(biscuit|can|bag|box|packet|bar|pancakes|cookies|slices) \((\d+ )?(NLEA )?serving/
    return nil
  when /[Ss]erving 100 ?ml/
    return 0.1
  when /serving (\d+) tbsp/i
    return tbsp($1)
  when /serving \d+ (pop|bar|packet|pieces|mints|stick)/
    return nil
  when /(fun size|bag|hot dog|cracker|straws|frank|grams|pancakes|links|biscuit|cherry|spray|slice|cone|sandwich|link|envelope)/
    return nil
  else
    #puts ">>>> #{desc}"
  end
  return nil
end

def density(g, l)
  return nil if (g.nil? or l.nil?)
  return (g/1000.0)/l
end

def density_from_set(weights)
  volumes = weights.map{|w|volume(w.description)}
  max = volumes.reject(&:nil?).max
  weight = weights[volumes.index(max)]
  volume = volume(weight.description)
  return density(weight.grams,volume)
end


task :import_weights => :environment do

  # There are several items specified like "item 3.5oz", but they all seem to be
  # things that would be measured in solid ounces, so we won't bother trying to get
  # a density from that.
  x = Weight.find(:all, :conditions => ["description LIKE ?", "%item%"])
  x.each do |weight|
    food_item = weight.food_item
    unless food_item.serving_size
      puts "Setting #{food_item.name}/SS to #{weight.grams}g"
      food_item.serving_size = weight.grams
      food_item.serving_size_unit = "Grammar::Vocabulary::Gram"
      food_item.save!
    end
  end
  # Here we're just going to blindly (and often incorrectly) assume that ounces are fluid ounces.
  # Users can correct the density later if it's a problem.
  # Nobody specifies non-fluid foods by volume anyway, so it's not like it's a big deal.
  x = Weight.find(:all, :conditions => ["description LIKE ?", "%serving%"])
  x.each do |weight|
    food_item = weight.food_item
    unless food_item.serving_size
      v = volume(weight.description)
      if v
        d = density(weight.grams,v)
        puts ">D< #{food_item.id} : #{d}"
        food_item.density = d
      end

      puts ">S< #{food_item.id} : #{weight.grams}"
      food_item.serving_size = weight.grams
      food_item.serving_size_unit = "Grammar::Vocabulary::Gram"
      food_item.save!
    end
  end

  x = Weight.all
  x.reject!{|w|w.description =~ /(item|serving)/}
  x=x.group_by(&:food_item_id)
  x.each do |food_item_id, weights|
    d = density_from_set(weights)
    if d
      puts ">D< #{food_item_id} : #{d}"
      f=FoodItem.find(food_item_id)
      f.density = d
      f.save!
    end
  end
  
end

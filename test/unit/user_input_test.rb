require 'test_helper'
require 'user_input'

## Warning this is a generated file, do not directly modify it.
##   Instead take a look at lib/tasks/test_generate.rake

class UserInputTest < ActiveSupport::TestCase
  test "breakfast three times" do
    result = UserInput.new("breakfast three times")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"breakfast three times"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "a meatball sub" do
    result = UserInput.new("a meatball sub")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"meatball sub"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "spaghetti" do
    result = UserInput.new("spaghetti")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"spaghetti"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "75 kg of a 100 kg bucket of chicken" do
    result = UserInput.new("75 kg of a 100 kg bucket of chicken")
    expected = {"unit"=>"Vocabulary::Gram", "count"=>7500000000.0, "foodSearch"=>"-INSTAFAIL-, does not do proportions, bucket of chicken"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "meatballs and cheese" do
    result = UserInput.new("meatballs and cheese")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"meatballs and cheese"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Lunch" do
    result = UserInput.new("Lunch")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"Lunch"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "cereal" do
    result = UserInput.new("cereal")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"cereal"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "bowl of cereal" do
    result = UserInput.new("bowl of cereal")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"bowl of cereal"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "a coffee" do
    result = UserInput.new("a coffee")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"coffee"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Diet Pepsi MAX" do
    result = UserInput.new("Diet Pepsi MAX")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"Diet Pepsi MAX"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "asdf" do
    result = UserInput.new("asdf")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"asdf"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "chicken" do
    result = UserInput.new("chicken")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"chicken"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Fuze Refresh" do
    result = UserInput.new("Fuze Refresh")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"Fuze Refresh"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "crackers and cottage cheese" do
    result = UserInput.new("crackers and cottage cheese")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"crackers and cottage cheese"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Nothing." do
    result = UserInput.new("Nothing.")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>0.0, "foodSearch"=>""}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "pea soup" do
    result = UserInput.new("pea soup")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"pea soup"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "oatmeal bar" do
    result = UserInput.new("oatmeal bar")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"oatmeal bar"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "two eggs on toast" do
    result = UserInput.new("two eggs on toast")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>2.0, "foodSearch"=>"eggs on toast"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "subway" do
    result = UserInput.new("subway")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"subway"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Bruschetta" do
    result = UserInput.new("Bruschetta")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"Bruschetta"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "eggs" do
    result = UserInput.new("eggs")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"eggs"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "marzipan" do
    result = UserInput.new("marzipan")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"marzipan"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "bread" do
    result = UserInput.new("bread")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"bread"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "a pound of bacon" do
    result = UserInput.new("a pound of bacon")
    expected = {"unit"=>"Vocabulary::Gram", "count"=>453.59237, "foodSearch"=>"bacon"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Reeses big cups" do
    result = UserInput.new("Reeses big cups")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"Reeses big cups"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "cheesecake, toast with jam, orange juice" do
    result = UserInput.new("cheesecake, toast with jam, orange juice")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"cheesecake, toast with jam, orange juice"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "goddamn sandwiches" do
    result = UserInput.new("goddamn sandwiches")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"sandwiches"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "oh henry bar" do
    result = UserInput.new("oh henry bar")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"oh henry bar"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "1 glass of orange juice" do
    result = UserInput.new("1 glass of orange juice")
    expected = {"unit"=>"Vocabulary::Litre", "count"=>0.25, "foodSearch"=>"orange juice"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "100g of marzipan" do
    result = UserInput.new("100g of marzipan")
    expected = {"unit"=>"Vocabulary::Gram", "count"=>100.0, "foodSearch"=>"marzipan"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "3 hotdogs and 4 glasses of coke" do
    result = UserInput.new("3 hotdogs and 4 glasses of coke")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>3.0, "foodSearch"=>"hotdogs and 4 glasses of coke"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "a cookie" do
    result = UserInput.new("a cookie")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"cookie"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "steak" do
    result = UserInput.new("steak")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"steak"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "two cookies" do
    result = UserInput.new("two cookies")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>2.0, "foodSearch"=>"cookies"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Very stale bread" do
    result = UserInput.new("Very stale bread")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"Bread"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "Two bottles of Heineken" do
    result = UserInput.new("Two bottles of Heineken")
    expected = {"unit"=>"Vocabulary::Litre", "count"=>0.682, "foodSearch"=>"Heineken"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "several pounds of bacon" do
    result = UserInput.new("several pounds of bacon")
    expected = {"unit"=>"Vocabulary::Gram", "count"=>2267.96185, "foodSearch"=>"bacon"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "tortellini and spaghetti sauce with beef and chicken" do
    result = UserInput.new("tortellini and spaghetti sauce with beef and chicken")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"tortellini and spaghetti sauce with beef and chicken"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "classic italian sandwich and a mandarin orange and coffee" do
    result = UserInput.new("classic italian sandwich and a mandarin orange and coffee")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"classic italian sandwich and a mandarin orange and coffee"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "1 taco" do
    result = UserInput.new("1 taco")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"taco"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "bacon chili cheesedog" do
    result = UserInput.new("bacon chili cheesedog")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"bacon chili cheesedog"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "cupcakes" do
    result = UserInput.new("cupcakes")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"cupcakes"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "pork and beans" do
    result = UserInput.new("pork and beans")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"pork and beans"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "The number of gumballs that fit in my hat." do
    result = UserInput.new("The number of gumballs that fit in my hat.")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>42.0, "foodSearch"=>"-INSTAFAIL- number of gumballs that fit in my hat."}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "food" do
    result = UserInput.new("food")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"food"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "pankakes, bacon, eggs, and hashbrowns" do
    result = UserInput.new("pankakes, bacon, eggs, and hashbrowns")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"pankakes, bacon, eggs, and hashbrowns"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "turd monkeys" do
    result = UserInput.new("turd monkeys")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>1.0, "foodSearch"=>"turd monkeys"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "three donuts" do
    result = UserInput.new("three donuts")
    expected = {"unit"=>"Vocabulary::Serving", "count"=>3.0, "foodSearch"=>"donuts"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
  test "3.5oz of marzipan" do
    result = UserInput.new("3.5oz of marzipan")
    expected = {"unit"=>"Vocabulary::Litre", "count"=>0.103507355, "foodSearch"=>"marzipan"}
    assert_equal result.count, expected["count"]
    assert_equal result.unit.to_s, expected["unit"]
    assert_equal result.foodSearch, expected["foodSearch"]
  end
end

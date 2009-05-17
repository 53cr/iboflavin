require 'test_helper'
require 'user_input'

class UserInputTest < ActiveSupport::TestCase
  def test_breakfast_three_times
    assert_equal UserInput.new("breakfast three times").mark_split, "three times:::breakfast"
  end
  def test_a_meatball_sub
    assert_equal UserInput.new("a meatball sub").mark_split, "a:::meatball sub"
  end
  def test_spaghetti
    assert_equal UserInput.new("spaghetti").mark_split, ":::spaghetti"
  end
  def test_75_kg_of_a_100_kg_bucket_of_chicken
    assert_equal UserInput.new("75 kg of a 100 kg bucket of chicken").mark_split, "75 kg of::: a 100 kg bucket of chicken"
  end
  def test_meatballs_and_cheese
    assert_equal UserInput.new("meatballs and cheese").mark_split, ":::meatballs and cheese"
  end
  def test_lunch
    assert_equal UserInput.new("Lunch").mark_split, ":::Lunch"
  end
  def test_cereal
    assert_equal UserInput.new("cereal").mark_split, ":::cereal"
  end
  def test_bowl_of_cereal
    assert_equal UserInput.new("bowl of cereal").mark_split, ":::bowl of cereal"
  end
  def test_a_coffee
    assert_equal UserInput.new("a coffee").mark_split, "a:::coffee"
  end
  def test_diet_pepsi_max
    assert_equal UserInput.new("Diet Pepsi MAX").mark_split, ":::Diet Pepsi MAX"
  end
  def test_asdf
    assert_equal UserInput.new("asdf").mark_split, ":::asdf"
  end
  def test_chicken
    assert_equal UserInput.new("chicken").mark_split, ":::chicken"
  end
  def test_fuze_refresh
    assert_equal UserInput.new("Fuze Refresh").mark_split, ":::Fuze Refresh"
  end
  def test_crackers_and_cottage_cheese
    assert_equal UserInput.new("crackers and cottage cheese").mark_split, ":::crackers and cottage cheese"
  end
  def test_nothing
    assert_equal UserInput.new("Nothing.").mark_split, ":::Nothing."
  end
  def test_pea_soup
    assert_equal UserInput.new("pea soup").mark_split, ":::pea soup"
  end
  def test_oatmeal_bar
    assert_equal UserInput.new("oatmeal bar").mark_split, ":::oatmeal bar"
  end
  def test_two_eggs_on_toast
    assert_equal UserInput.new("two eggs on toast").mark_split, "two:::eggs on toast"
  end
  def test_subway
    assert_equal UserInput.new("subway").mark_split, ":::subway"
  end
  def test_bruschetta
    assert_equal UserInput.new("Bruschetta").mark_split, ":::Bruschetta"
  end
  def test_eggs
    assert_equal UserInput.new("eggs").mark_split, ":::eggs"
  end
  def test_marzipan
    assert_equal UserInput.new("marzipan").mark_split, ":::marzipan"
  end
  def test_bread
    assert_equal UserInput.new("bread").mark_split, ":::bread"
  end
  def test_a_pound_of_bacon
    assert_equal UserInput.new("a pound of bacon").mark_split, "a pound of:::bacon"
  end
  def test_reeses_big_cups
    assert_equal UserInput.new("Reeses big cups").mark_split, ":::Reeses big cups"
  end
  def test_cheesecake_toast_with_jam_orange_juice
    assert_equal UserInput.new("cheesecake, toast with jam, orange juice").mark_split, ":::cheesecake, toast with jam, orange juice"
  end
  def test_goddamn_sandwiches
    assert_equal UserInput.new("goddamn sandwiches").mark_split, ":::goddamn sandwiches"
  end
  def test_oh_henry_bar
    assert_equal UserInput.new("oh henry bar").mark_split, ":::oh henry bar"
  end
  def test_1_glass_of_orange_juice
    assert_equal UserInput.new("1 glass of orange juice").mark_split, "1 glass of:::orange juice"
  end
  def test_100g_of_marzipan
    assert_equal UserInput.new("100g of marzipan").mark_split, "100g of:::marzipan"
  end
  def test_3_hotdogs_and_4_glasses_of_coke
    assert_equal UserInput.new("3 hotdogs and 4 glasses of coke").mark_split, "3:::hotdogs and 4 glasses of coke"
  end
  def test_a_cookie
    assert_equal UserInput.new("a cookie").mark_split, "a:::cookie"
  end
  def test_steak
    assert_equal UserInput.new("steak").mark_split, ":::steak"
  end
  def test_two_cookies
    assert_equal UserInput.new("two cookies").mark_split, "two:::cookies"
  end
  def test_very_stale_bread
    assert_equal UserInput.new("Very stale bread").mark_split, ":::Very stale bread"
  end
  def test_two_bottles_of_heineken
    assert_equal UserInput.new("Two bottles of Heineken").mark_split, "Two bottles of:::Heineken"
  end
  def test_several_pounds_of_bacon
    assert_equal UserInput.new("several pounds of bacon").mark_split, "several pounds of:::bacon"
  end
  def test_tortellini_and_spaghetti_sauce_with_beef_and_chicken
    assert_equal UserInput.new("tortellini and spaghetti sauce with beef and chicken").mark_split, ":::tortellini and spaghetti sauce with beef and chicken"
  end
  def test_classic_italian_sandwich_and_a_mandarin_orange_and_coffee
    assert_equal UserInput.new("classic italian sandwich and a mandarin orange and coffee").mark_split, ":::classic italian sandwich and a mandarin orange and coffee"
  end
  def test_1_taco
    assert_equal UserInput.new("1 taco").mark_split, "1:::taco"
  end
  def test_bacon_chili_cheesedog
    assert_equal UserInput.new("bacon chili cheesedog").mark_split, ":::bacon chili cheesedog"
  end
  def test_cupcakes
    assert_equal UserInput.new("cupcakes").mark_split, ":::cupcakes"
  end
  def test_pork_and_beans
    assert_equal UserInput.new("pork and beans").mark_split, ":::pork and beans"
  end
  def test_the_number_of_gumballs_that_fit_in_my_hat
    assert_equal UserInput.new("The number of gumballs that fit in my hat.").mark_split, "The number that fit in my hat of:::gumballs."
  end
  def test_food
    assert_equal UserInput.new("food").mark_split, ":::food"
  end
  def test_pankakes_bacon_eggs_and_hashbrowns
    assert_equal UserInput.new("pankakes, bacon, eggs, and hashbrowns").mark_split, ":::pankakes, bacon, eggs, and hashbrowns"
  end
  def test_turd_monkeys
    assert_equal UserInput.new("turd monkeys").mark_split, ":::turd monkeys"
  end
  def test_three_donuts
    assert_equal UserInput.new("three donuts").mark_split, "three:::donuts"
  end
  def test_35oz_of_marzipan
    assert_equal UserInput.new("3.5oz of marzipan").mark_split, "3.5oz of:::marzipan"
  end
end

class EntryMatchObserver < ActiveRecord::Observer
  observe :entry_match

  def after_create(record)  
    # For each Goal, add this entryMatch's total nutrients to the tokyo data entry
    change_goal_cache(record) do |nutrient|
      record.amount_of_nutrient(nutrient)
    end
  end

  def after_update(record)
    # For each Goal, add the different in the previous and new values.
    change_goal_cache(record) do |nutrient|
      record.amount_of_nutrient(nutrient) - record.amount_of_nutrient(nutrient,true)
    end
  end
  
  def before_destroy(record)
    # For each Goal, remove this entryMatch's total nutrients from the tokyo data entry
    change_goal_cache(record) do |nutrient|
      (-1)*(record.amount_of_nutrient(nutrient))
    end
  end

  private
  def change_goal_cache(record)
    if record.is_today
      goals = Goal.find_all_by_user_id(record.user_id)
      nutrients = goals.map(&:nutrient_id)
      # We'll always track calories (208 -- Energy by kCal)
      (nutrients << 208) unless nutrients.index(208)
      nutrients.each do |nutrient|
        change = yield nutrient
        GoalCache.add(record.user_id, nutrient, change)
      end
    end
  end
  
end


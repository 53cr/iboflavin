class EntryMatchObserver < ActiveRecord::Observer
  observe :entry_match

  def after_create(record)  
    # For each Goal, add this entryMatch's total nutrients to the tokyo data entry
    goals = Goal.find_all_by_user_id(record.user_id)
    goals.each do |goal|
      total = record.amount_of_nutrient(goal.nutrient_id)
      GoalCache.add(record.user_id, goal.nutrient_id, total)
    end
  end

  def after_update(record)
    # For each Goal, add the different in the previous and new values.
    if record.is_today
      goals = Goal.find_all_by_user_id(record.user_id)
      goals.each do |goal|
        difference = record.amount_of_nutrient(goal.nutrient_id,true) -
          record.amount_of_nutrient(goal.nutrient_id)
        GoalCache.add(record.user_id, goal.nutrient_id, difference)
      end
    end
  end
  
  def before_destroy(record)
    # For each Goal, remove this entryMatch's total nutrients from the tokyo data entry
    if record.is_today
      goals = Goal.find_all_by_user_id(record.user_id)
      goals.each do |goal|
        total = (-1)*(record.amount_of_nutrient(goal.nutrient_id))
        GoalCache.add(record.user_id, goal.nutrient_id, total)
      end
    end
  end
  
end

class GoalObserver < ActiveRecord::Observer
  observe :goal

  def after_create(record)
    cond = ["user_id = ? AND created_at >= ?",record.user_id,Date.today]
    recent = Entry.find(:all, :conditions => cond, :order => 'id DESC')
    total = recent.
      map{|e|e.amount_of_nutrient(record.nutrient_id)}.
      compact.
      inject(&:+)
    GoalCache.set(record.user_id, record.nutrient_id, total)
  end

  def after_update(record)
    # May need this in the future, but not really now...
  end
  
  def after_destroy(record)
    GoalCache.destroy(record.user_id, record.nutrient_id)
  end
  
end

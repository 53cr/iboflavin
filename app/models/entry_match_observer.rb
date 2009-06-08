class EntryMatchObserver < ActiveRecord::Observer
  observe :entry_match

  def after_create(record)  
    # For each Goal, add this entryMatch's total nutrients to the tokyo data entry
  end

  def after_update(record)
    # For each Goal, add the different in the previous and new values.
  end
  
  def after_destroy(record)
    # For each Goal, remove this entryMatch's total nutrients from the tokyo data entry
  end
  
end

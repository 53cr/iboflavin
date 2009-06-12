class GoalCache

  def self.find(user, nutrient)
    x = TOKYO[key_for(user,nutrient)]
    return (x.nil? ? 0 : x.to_f)
  end

  def self.destroy(user,nutrient)
    TOKYO.delete(key_for(user,nutrient))
  end

  def self.add(user,nutrient,amount)
    curr = find(user,nutrient) || 0
    set(user,nutrient,curr+amount)
  end

  def self.set(user,nutrient,value)
    TOKYO[key_for(user,nutrient)] = value.to_s
  end
  
  private
  def self.key_for(user,nutrient)
    "g_u:#{user};n#{nutrient}"
  end

end

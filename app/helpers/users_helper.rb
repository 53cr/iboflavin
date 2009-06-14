module UsersHelper
  def lifestyle_select_options
    [["--Select--",nil],
     ['Sedentary','sedentary'], 
     ['Low Active', 'low active'],
     ['Active','active']]
  end
  def sex_select_options
    [["--Select--",nil],['Male','male'],['Female','female']]
  end
  def birthday_select_settings
    { :start_year => 1900, 
      :end_year => Time.now.year, 
      :order => [:month, :day, :year],
      :default => Date.today - 25.years
    }
  end
end

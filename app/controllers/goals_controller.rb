class GoalsController < ApplicationController

  def sidebar

    @recent = Entry.find(:all, :conditions => ["user_id = ? AND created_at >= ?",@current_user.id,Date.today], :order => 'id DESC')
    riboflavin,calories = 405,208
    @calories_today = @recent.map{|e|e.amount_of_nutrient(calories)}.compact.inject(&:+)
    @b2_today = @recent.map{|e|e.amount_of_nutrient(riboflavin)}.compact.inject(&:+)
    @b2_total = @current_user.rdi_for(Nutrient.find(405))
    
    render :partial => 'sidebar', :layout => false
  end

end

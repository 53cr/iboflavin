class Entry < ActiveRecord::Base

  after_save :create_entry_matches
  before_destroy :destroy_entry_matches

  validates_format_of :input, :with => /\S+/
  
  belongs_to :user
  has_many :entry_matches

  def amount_of_nutrient(nut)
    self.entry_matches.map{|em|em.amount_of_nutrient(nut)}.inject(&:+)
  end
  
  private
  def create_entry_matches
    items = Grammar::parse(self.input)

    items.each do |item|
      EntryMatch.create!({
              :user_id => self.user_id,
              :entry_id => self.id,
              :search => item[2],
              :amount => item[0],
              :unit => item[1].to_s
      })
    end
    
  end

  def destroy_entry_matches
    self.entry_matches.map(&:destroy)
  end

end

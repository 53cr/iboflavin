class Entry < ActiveRecord::Base

  after_save :create_entry_matches

  belongs_to :user
  has_many :entry_matches
  
  private
  def create_entry_matches

    items = Grammar::parse(self.input)

    items.each do |item|
      EntryMatch.create!({:user_id => self.user_id, :entry_id => self.id, :search => item[2], :amount => item[0], :unit => item[1].to_s})
    end
    
  end

  
end

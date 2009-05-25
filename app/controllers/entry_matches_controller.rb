class EntryMatchesController < ApplicationController

  #TODO: Make this not suck.
  skip_before_filter :verify_authenticity_token 


  #TODO: Make sure this entry belongs to this user!
  #TODO: And other verifications...
  def update_amount
    id = params[:id] # edit-amount-<ID>
    id = id.split('-').last.to_i
    value = params[:value]
    ematch = EntryMatch.find(id)

    amount, unit = Grammar::parse_quantifier(Grammar::tokenize(value))

    ematch.update_attributes!({:amount => amount, :unit => unit.to_s})

    render :text => ematch.humanize_amount
  end

end

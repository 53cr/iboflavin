class EntryMatchesController < ApplicationController

  before_filter :require_user

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

  def index
    @entry_matches = EntryMatch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entry_matches }
    end
  end

  def show
    @entry_match = EntryMatch.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml  => @entry_match }
      format.json { render :json => {:entry_match => @entry_match, :entry_matches => @entry_match.entry_matches}.to_json }
    end
  end

  def create
    @entry_match = EntryMatch.new(params[:entry_match].merge({:user_id => @current_user.id}))

    respond_to do |format|
      if @entry_match.save
        format.html { redirect_to(@entry_match) }
        format.xml  { render :xml  => @entry_match, :status => :created, :location => @entry_match }
        format.json { render :json => @entry_match, :status => :created, :location => @entry_match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml  => @entry_match.errors, :status => :unprocessable_entity }
        format.json { render :json => @entry_match.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @entry_match = EntryMatch.find(params[:id])

    respond_to do |format|
      if @entry_match.update_attributes(params[:entry_match])
        flash[:notice] = 'EntryMatch was successfully updated.'
        format.html { redirect_to(@entry_match) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry_match.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry_match = EntryMatch.find(params[:id])
    @entry_match.destroy

    respond_to do |format|
      format.html { redirect_to(entry_matches_url) }
      format.xml  { head :ok }
      format.js   { render :nothing => true }
    end
  end

  
end

class EntryMatchesController < ApplicationController

  before_filter :require_user

  # We have to deal with input from jeditable here. 
  def update
    # id will sometimes be in-place-edit-9323 or something like that.
    id = params[:id].split('-').last 

    if params[:entry_match][:value]
      a,u = Grammar::parse_quantifier(Grammar::tokenize(params[:entry_match][:value]))
      params[:entry_match][:amount], params[:entry_match][:unit] = a,u.to_s
      params[:entry_match].delete(:value)
    end

    @entry_match = EntryMatch.find(id)
    if @current_user.id != @entry_match.user_id
      redirect_to '/'
    else
      
      respond_to do |format|
        if @entry_match.update_attributes(params[:entry_match])
          # flash[:notice] = 'EntryMatch was successfully updated.'
          format.html { redirect_to(@entry_match) }
          format.xml  { head :ok }
          format.js   { }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @entry_match.errors, :status => :unprocessable_entity }
          format.js   { render :text => '' }
        end
      end
    end
  end

  def alternates
    @entry_match = EntryMatch.find(params[:id])
    if @current_user.id != @entry_match.user_id
      redirect_to '/'
    else
      search = params[:search] || @entry_match.search
      
      @food_items = FoodItem.awesome_search(@current_user.id, search)

      respond_to do |format|
        format.html { render :layout => false } 
        format.xml  { render :xml => @food_items }
      end
    end
  end

  def show
    @entry_match = EntryMatch.find(params[:id])
    if @current_user.id != @entry_match.user_id
      redirect_to '/'
    else
      respond_to do |format|
        format.html { render :layout => false }
        format.xml  { render :xml  => @entry_match }
        format.json { render :json => {:entry_match => @entry_match, :entry_matches => @entry_match.entry_matches}.to_json }
      end
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


  def destroy
    @entry_match = EntryMatch.find(params[:id])
    if @current_user.id != @entry_match.user_id
      redirect_to '/'
    else
      @entry_match.destroy

      respond_to do |format|
        format.html { redirect_to(entry_matches_url) }
        format.xml  { head :ok }
        format.js   { render :nothing => true }
      end
    end
  end

  
end

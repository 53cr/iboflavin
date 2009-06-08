class EntriesController < ApplicationController

  before_filter :require_user

  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml  => @entry }
      format.json { render :json => {:entry => @entry, :entry_matches => @entry.entry_matches}.to_json }
    end
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new

    @recent = Entry.find(:all, :conditions => ["user_id = ? AND created_at >= ?",@current_user.id,Date.today], :order => 'id DESC')

    @calories_today = @recent.map{|e|e.amount_of_nutrient(208)}.compact.inject(&:+)
    @b2_today = @recent.map{|e|e.amount_of_nutrient(405)}.compact.inject(&:+)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry].merge({:user_id => @current_user.id}))

    respond_to do |format|
      if @entry.save
        format.html { redirect_to(@entry) }
        format.xml  { render :xml  => @entry, :status => :created, :location => @entry }
        format.json { render :json => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml  => @entry.errors, :status => :unprocessable_entity }
        format.json { render :json => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
      format.js   { render :nothing => true }
    end
  end
end

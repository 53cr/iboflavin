class GoalsController < ApplicationController
  def sidebar
    render :partial => 'sidebar', :layout => false
  end

  def index
    @goals = @current_user.goals

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @goals }
    end
  end

  def show
    @goal = Goal.find(params[:id], :include => :nutrient)
    require_ownership(@goal) do
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @goal }
      end
    end
  end

  def new
    @goal = Goal.new
    require_ownership(@goal) do
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @goal }
      end
    end
  end

  def edit
    @goal = Goal.find(params[:id],:include => :nutrient)
    require_ownership(@goal)
  end

  def create
    @goal = Goal.new(params[:goal])
    @goal.user_id=@current_user.id
    respond_to do |format|
      if @goal.save
        flash[:notice] = 'Goal was successfully created.'
        format.html { redirect_to(@goal) }
        format.xml  { render :xml => @goal, :status => :created, :location => @goal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @goal = Goal.find(params[:id])
    require_ownership(@goal) do
      respond_to do |format|
        if @goal.update_attributes(params[:goal])
          flash[:notice] = 'Goals was successfully updated.'
          format.html { redirect_to(@goal) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    require_ownership(@goal) do
      @goal.destroy

      respond_to do |format|
        format.html { redirect_to(goals_url) }
        format.xml  { head :ok }
      end
    end
  end
end



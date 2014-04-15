class ScrewsController < ApplicationController
  before_filter :find_screw, :only => [:show, :edit, :update, :destroy]

  # GET /screws
  # GET /screws.xml
  def index
    @screws = Screw.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @screws }
    end
  end

  # GET /screws/1
  # GET /screws/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @screw }
    end
  end

  # GET /screws/new
  # GET /screws/new.xml
  def new
    @screw = Screw.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @screw }
    end
  end

  # GET /screws/1/edit
  def edit
  end

  # POST /screws
  # POST /screws.xml
  def create
    @screw = Screw.new(params[:screw].permit(:size, :length, :threading, :drawer_ids, :drawers))
    @screw.drawer_ids = params[:screw][:drawer_ids]
    @screw.save

    respond_to do |wants|
      if @screw.save
        flash[:notice] = 'Screw was successfully created.'
        wants.html { redirect_to(@screw) }
        wants.xml  { render :xml => @screw, :status => :created, :location => @screw }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @screw.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /screws/1
  # PUT /screws/1.xml
  def update
    respond_to do |wants|
      if @screw.update_attributes(params[:screw])
        flash[:notice] = 'Screw was successfully updated.'
        wants.html { redirect_to(@screw) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @screw.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /screws/1
  # DELETE /screws/1.xml
  def destroy
    @screw.destroy

    respond_to do |wants|
      wants.html { redirect_to(screws_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_screw
      @screw = Screw.find(params[:id])
    end

end

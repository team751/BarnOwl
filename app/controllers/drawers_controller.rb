class DrawersController < ApplicationController
  before_filter :find_drawer, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  
  # GET /drawers
  # GET /drawers.xml
  def index
    @drawers = Drawer.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @drawers }
    end
  end

  # GET /drawers/1
  # GET /drawers/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @drawer }
    end
  end

  # GET /drawers/new
  # GET /drawers/new.xml
  def new
    @drawer = Drawer.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @drawer }
    end
  end

  # GET /drawers/1/edit
  def edit
  end

  # POST /drawers
  # POST /drawers.xml
  def create
    @drawer = Drawer.new(params[:drawer].permit(:label, :row, :column))

    respond_to do |wants|
      if @drawer.save
        flash[:notice] = 'Drawer was successfully created.'
        wants.html { redirect_to("/drawers/new") }
        wants.xml  { render :xml => @drawer, :status => :created, :location => @drawer }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @drawer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /drawers/1
  # PUT /drawers/1.xml
  def update
    respond_to do |wants|
      if @drawer.update_attributes(params[:drawer])
        flash[:notice] = 'Drawer was successfully updated.'
        wants.html { redirect_to(@drawer) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @drawer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /drawers/1
  # DELETE /drawers/1.xml
  def destroy
    @drawer.destroy

    respond_to do |wants|
      wants.html { redirect_to(drawers_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_drawer
      @drawer = Drawer.find(params[:id])
    end

end

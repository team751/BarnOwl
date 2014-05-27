class PartManagerController < ApplicationController
  def index
    @assemblies = Assembly.where(:year => 2014)
    render "index", layout: "application_table"
  end
  
  def show
    @assembly = Assembly.find(params[:id])
  end
  
  def edit
    @assembly = Assembly.find(params[:id])
  end
  
  def edit_part
    @part = Part.find(params[:id])
  end
  
  def new
    @assembly = Assembly.new
  end
  
  def new_part
    @part = Part.new
  end
  
  def create
    @assembly = Assembly.new(params[:assembly].permit(:name, :year, :prefix, :state_store))

    respond_to do |wants|
      if @assembly.save
        flash[:notice] = 'Assembly was successfully created.'
        wants.html { redirect_to(@assembly) }
        wants.xml  { render :xml => @assembly, :status => :created, :location => @assembly }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @assembly.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create_part
    @part = Part.new(params[:part].permit(:name, :state_store, :assembly_id))
    @part.assembly = Assembly.find(params[:id])
    respond_to do |wants|
      if @part.save
        flash[:notice] = 'Part was successfully created.'
        wants.html { redirect_to("/parts/#{@part.assembly.id}") }
        wants.xml  { render :xml => @part, :status => :created, :location => @part }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @part.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @assembly = Assembly.find(params[:id])
    
    respond_to do |wants|
      if @assembly.update_attributes(params[:assembly].permit(:name, :prefix, :year, :state_store))
        @assembly.save
        flash[:notice] = 'Assembly was successfully updated.'
        wants.html { redirect_to("/parts") }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @assembly.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update_part
    @part = Part.find(params[:id])
    
    respond_to do |wants|
      if @part.update_attributes(params[:part].permit(:name, :state_store, :assembly_id))
        @part.save
        flash[:notice] = 'Part was successfully updated.'
        wants.html { redirect_to("/parts/#{@part.assembly.id}") }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @part.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @assembly = Assembly.find(params[:id])
    @assembly.destroy

    respond_to do |wants|
      wants.html { redirect_to("/parts") }
      wants.xml  { head :ok }
    end
  end
end

class ItemsController < ApplicationController
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item].permit(:name, :price, :drawer_ids))
    @item.drawer_ids = params[:item][:drawer_ids]
    @item.save
    
    respond_to do |wants|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        wants.html { redirect_to("/items/new") }
        wants.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    respond_to do |wants|
      if @item.update_attributes(params[:item].permit(:name, :price, :drawer_ids))
        @item.drawer_ids = params[:item][:drawer_ids]
        @item.save
        flash[:notice] = 'Item was successfully updated.'
        wants.html { redirect_to(@item) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item.destroy

    respond_to do |wants|
      wants.html { redirect_to(items_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_item
      @item = Item.find(params[:id])
    end

end

class HomeController < ApplicationController
  def index
  end
  
  def autocomplete
    results = []
    Drawer.search(params[:q]).each do |result|
      r = {}
      r[:_id] = result["_id"]
      r[:label] = result[:_source][:label]
      r[:model] = "drawer"
      results << r
    end
    
    Item.search(params[:q]).each do |result|
      r = {}
      r[:_id] = result["_id"]
      r[:label] = result[:_source][:name]
      r[:model] = "items"
      results << r
    end
    render :json => results
  end
end

class HomeController < ApplicationController
  def index
  end
  
  def autocomplete
    results = []
    Item.search(params[:q]).each do |result|
      r = {}
      r[:_id] = result["_id"]
      r[:label] = result[:_source][:name]
      r[:model] = "item"
      results << r
    end
    
    # Drawer.search(params[:q]).each do |result|
    #   r = {}
    #   r[:_id] = result["_id"]
    #   r[:label] = result[:_source][:label]
    #   r[:model] = "drawer"
    #   results << r
    # end
    render :json => results
  end
  
  def searchbybarcode
    begin
      Item.where(barcode: params[:q]).each do |result|
        redirect_to "/items/#{result.id}"
        return
      end
    
      Screw.where(barcode: params[:q]).each do |result|
        redirect_to "/screws/#{result.id}"
        return
      end
    
      Item.search(params[:q]).each do |result|
        redirect_to "/items/#{result["_id"]}"
        return
      end
      if request.referrer
        redirect_to request.referrer
      else
        redirect_to "/"
      end
    rescue Exception => e
      if request.referrer
        redirect_to request.referrer
      else
        redirect_to "/"
      end
    end
  end
end

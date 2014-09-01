class OrderItem
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :mcmasterPartNumber, type: String
  field :order_state, type: String
  field :price, type: String
  field :ordered_by_id, type: String
  field :requested_by_id, type: String
  
  belongs_to :ordered_by, :class_name => "User"
  belongs_to :requested_by, :class_name => "User"
  
  def state_int
    if order_state == "ready"
      0
    elsif order_state == "placed"
      1
    elsif order_state == "hold"
      2
    elsif order_state == "received"
      3
    else
      4
    end
  end
  
  def state_html
    resp = "<span class=\"label label"
    if order_state == "ready"
      resp = "#{resp}-success\">Ready to be ordered</span>"
    elsif order_state == "placed"
      resp = "#{resp}-info\">Item ordered</span>"
    elsif order_state == "hold"
      resp = "#{resp}-warning\">Item on hold</span>"
    elsif order_state == "received"
      resp = "#{resp}-primary\">Item received</span>"
    else
      resp = ""
    end
    
    resp
  end
  
  def logic_url
    if mcmasterPartNumber != "" && mcmasterPartNumber
      "http://www.mcmaster.com/##{mcmasterPartNumber}"
    else
      url
    end
  end
  
  def next_step_title
    if order_state == "ready"
      "Order item"
    elsif order_state == "placed"
      "Recieve item"
    elsif order_state == "hold"
      "Ready to place order"
    else
      ""
    end
  end
  
  def next_step_url
    if order_state == "ready"
      "/order_items/#{id}/status/placed"
    elsif order_state == "placed"
      "/order_items/#{id}/status/received"
    elsif order_state == "hold"
      "/order_items/#{id}/status/ready"
    else
      ""
    end
  end
end

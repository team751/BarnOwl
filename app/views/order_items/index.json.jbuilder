json.array!(@order_items) do |order_item|
  json.extract! order_item, :id, :name, :url, :mcmasterPartNumber, :order_state, :ordered_by_id, :requested_by_id
  json.url order_item_url(order_item, format: :json)
end

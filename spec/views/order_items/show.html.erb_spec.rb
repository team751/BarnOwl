require 'spec_helper'

describe "order_items/show" do
  before(:each) do
    @order_item = assign(:order_item, stub_model(OrderItem,
      :name => "Name",
      :url => "Url",
      :mcmasterPartNumber => "Mcmaster Part Number",
      :order_state => "Order State",
      :ordered_by_id => "Ordered By",
      :requested_by_id => "Requested By"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Url/)
    rendered.should match(/Mcmaster Part Number/)
    rendered.should match(/Order State/)
    rendered.should match(/Ordered By/)
    rendered.should match(/Requested By/)
  end
end

require 'spec_helper'

describe "order_items/index" do
  before(:each) do
    assign(:order_items, [
      stub_model(OrderItem,
        :name => "Name",
        :url => "Url",
        :mcmasterPartNumber => "Mcmaster Part Number",
        :order_state => "Order State",
        :ordered_by_id => "Ordered By",
        :requested_by_id => "Requested By"
      ),
      stub_model(OrderItem,
        :name => "Name",
        :url => "Url",
        :mcmasterPartNumber => "Mcmaster Part Number",
        :order_state => "Order State",
        :ordered_by_id => "Ordered By",
        :requested_by_id => "Requested By"
      )
    ])
  end

  it "renders a list of order_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Mcmaster Part Number".to_s, :count => 2
    assert_select "tr>td", :text => "Order State".to_s, :count => 2
    assert_select "tr>td", :text => "Ordered By".to_s, :count => 2
    assert_select "tr>td", :text => "Requested By".to_s, :count => 2
  end
end

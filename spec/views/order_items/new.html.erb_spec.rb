require 'spec_helper'

describe "order_items/new" do
  before(:each) do
    assign(:order_item, stub_model(OrderItem,
      :name => "MyString",
      :url => "MyString",
      :mcmasterPartNumber => "MyString",
      :order_state => "MyString",
      :ordered_by_id => "MyString",
      :requested_by_id => "MyString"
    ).as_new_record)
  end

  it "renders new order_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_items_path, "post" do
      assert_select "input#order_item_name[name=?]", "order_item[name]"
      assert_select "input#order_item_url[name=?]", "order_item[url]"
      assert_select "input#order_item_mcmasterPartNumber[name=?]", "order_item[mcmasterPartNumber]"
      assert_select "input#order_item_order_state[name=?]", "order_item[order_state]"
      assert_select "input#order_item_ordered_by_id[name=?]", "order_item[ordered_by_id]"
      assert_select "input#order_item_requested_by_id[name=?]", "order_item[requested_by_id]"
    end
  end
end

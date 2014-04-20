# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    name "MyString"
    url "MyString"
    mcmasterPartNumber "MyString"
    order_state "MyString"
    ordered_by_id "MyString"
    requested_by_id "MyString"
  end
end

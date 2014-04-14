# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "MyString"
    price 1.5
    category_id 1
  end
end

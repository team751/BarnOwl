# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assembly do
    state_store "MyString"
    name "MyString"
    prefix "MyString"
  end
end

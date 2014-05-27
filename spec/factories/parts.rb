# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part do
    state_store "MyString"
    name "MyString"
    assembly_id "MyString"
  end
end

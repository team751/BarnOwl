# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_entry do
    user_id "MyString"
    clock_in_time "2014-06-17 15:09:05"
    clock_out_time "2014-06-17 15:09:05"
  end
end

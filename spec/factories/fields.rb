# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :field do
    environment "MyString"
    database "MyString"
    description "MyText"
    field_name "MyString"
    validation_edit "MyString"
    type ""
    size 1
  end
end

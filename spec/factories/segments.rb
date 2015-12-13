# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :segment do
    strain "MyString"
    locus "MyString"
    sequence "MyText"
    series_id 1
  end
end

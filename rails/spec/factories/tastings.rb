FactoryGirl.define do
  factory :tasting do |t|
    t.title { Faker::Lorem.sentence }
  end
end

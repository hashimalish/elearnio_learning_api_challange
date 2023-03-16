FactoryBot.define do
  factory :course do
    name { Faker::Name.name }
    position { Faker::Number.number(digits: 1) }
    association :author, factory: :author
  end
end

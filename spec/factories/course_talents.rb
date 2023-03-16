FactoryBot.define do
  factory :course_talent do
    association :talent, factory: :talent
    association :course, factory: :course
    completed { false }
  end
end
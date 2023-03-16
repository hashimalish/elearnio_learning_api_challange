FactoryBot.define do
  factory :learning_path do
    name { Faker::Name.name }
    transient do
      courses_count { 1 }
    end
    initialize_with do
      new(attributes).tap do |learning_path|
        learning_path.courses = build_list(:course, courses_count, learning_path: learning_path)
      end
    end
  end
end

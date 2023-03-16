require 'faker'
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

def seed
  seed_authors
  seed_talents
  seed_courses
  seed_learning_paths
end

def seed_authors
  puts '...seeding authors'
  create_list(:author, 3)
end

def seed_talents
  puts '...seeding talents'
  create_list(:talent, 3)
end

def seed_courses
  puts '...seeding courses'
  create_list(:course, 3)
end

def seed_learning_paths
  puts '...seeding learning paths'
  create_list(:learning_path, 3)
end

puts 'seeding'
seed
class Author < ApplicationRecord
  has_many :courses, as: :author

  validates :name, presence: true
end
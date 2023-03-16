class Course < ApplicationRecord
  belongs_to :learning_path, optional: true
  belongs_to :author, polymorphic: true
  has_many :course_talents, dependent: :destroy
  has_many :talents, -> { distinct }, through: :course_talents

  validates :position, numericality: { only_integer: true }
end
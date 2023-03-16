class LearningPath < ApplicationRecord
  has_many :courses, -> { order(position: :asc) }, dependent: :nullify, before_add: :validate_course_addition
  has_many :learning_path_talents, dependent: :destroy
  has_many :talents, -> { distinct }, through: :learning_path_talents

  validates :courses, presence: true, length: { minimum: 1 }
  validates :name, presence: true

  private

  def validate_course_addition(course)
    if courses.include?(course)
      errors.add(:base, 'Course already added to learning path')
      raise ActiveRecord::RecordInvalid.new(self)
    end

    if courses.exists?(position: course.position)
      errors.add(:base, 'Course has duplicate position in learning path')
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
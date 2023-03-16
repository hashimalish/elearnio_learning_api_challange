class Talent < ApplicationRecord
  has_many :course_talents, dependent: :destroy
  has_many :course_enrollments, -> { distinct }, through: :course_talents, source: :course
  has_many :learning_path_talents, dependent: :destroy
  has_many :learning_paths, -> { distinct }, through: :learning_path_talents
  has_many :authored_courses, class_name: 'Course', as: :author

  validates :name, presence: true

  def mark_course_as_completed(course)
    course_talents.find_by(course: course)&.update!(completed: true)
    next_course = next_course_in_learning_path(course)

    course_enrollments << next_course if next_course.present?
  end

  def next_course_in_learning_path(current_course)
    learning_path = current_course.learning_path
    next_course = learning_path&.courses&.where('position > ?', current_course.position)&.first
  end

  def is_course_completed?(course)
    course_talents.find_by(course: course)&.completed?
  end
end
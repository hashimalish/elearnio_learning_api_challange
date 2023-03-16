class LearningPathTalent < ApplicationRecord
  belongs_to :learning_path
  belongs_to :talent

  after_create :assign_initial_course_to_talent

  private

  def assign_initial_course_to_talent
  	talent.course_enrollments << learning_path.courses.first
  end
end
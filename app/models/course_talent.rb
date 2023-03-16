class CourseTalent < ApplicationRecord
  belongs_to :talent
  belongs_to :course

  validate :course_not_authored_by_talent

  def complete!
    update!(completed: true)

    next_course = talent.next_course_in_learning_path(course)
    talent.course_enrollments << next_course if next_course.present?
  end

  private

  def course_not_authored_by_talent
    if talent&.authored_courses&.exists?(id: course.id)
      errors.add(:course, 'Cannot enroll in a course authored by the same talent')
    end
  end
end
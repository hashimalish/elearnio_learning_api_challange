require 'rails_helper'

RSpec.describe CourseTalent, type: :model do
  let(:talent) { create(:talent) }
  let(:course) { create(:course, position: 1) }
  let(:course_talent) { create(:course_talent, talent: talent, course: course) }

  describe 'associations' do
    it { should belong_to(:talent) }
    it { should belong_to(:course) }
  end

  describe 'validations' do
    it 'validates that course is not authored by talent' do
      authored_course = create(:course, author: talent)
      course_talent = build(:course_talent, talent: talent, course: authored_course)
      expect(course_talent).not_to be_valid
      expect(course_talent.errors.full_messages).to include('Course Cannot enroll in a course authored by the same talent')
    end
  end

  describe '#complete!' do
    let(:next_course) { create(:course, position: 2) }
    let(:learning_path) { create(:learning_path, course_ids: [course.id, next_course.id]) }

    before { talent.course_enrollments << course }

    it 'marks the course as completed' do
      expect { course_talent.complete! }.to change { course_talent.reload.completed }.from(false).to(true)
    end

    context 'when there is a next course in the learning path' do
      before { allow(talent).to receive(:next_course_in_learning_path).with(course).and_return(next_course) }

      it 'adds the next course to the talent courses' do
        expect { course_talent.complete! }.to change { talent.course_enrollments.count }.by(1)
        expect(talent.course_enrollments.last).to eq next_course
      end
    end

    context 'when there is no next course in the learning path' do
      before { allow(talent).to receive(:next_course_in_learning_path).with(course).and_return(nil) }

      it 'does not add any course to the talent courses' do
        expect { course_talent.complete! }.not_to change { talent.course_enrollments.count }
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:learning_path).optional }
    it { should belong_to(:author) }
    it { should have_many(:course_talents) }
    it { should have_many(:talents).through(:course_talents) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:position).only_integer }
  end
end
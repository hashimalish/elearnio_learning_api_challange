require 'rails_helper'

RSpec.describe LearningPathTalent, type: :model do
  describe 'associations' do
    it { should belong_to(:learning_path) }
    it { should belong_to(:talent) }
  end
end
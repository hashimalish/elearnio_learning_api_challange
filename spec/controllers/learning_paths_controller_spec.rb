require 'rails_helper'

RSpec.describe LearningPathsController, type: :controller do
  describe 'GET index' do
    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns all learning paths' do
      learning_path1 = create(:learning_path, courses_count: 2)
      learning_path2 = create(:learning_path, courses_count: 2)

      get :index

      expect(assigns(:learning_paths)).to match_array([learning_path1, learning_path2])
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      learning_path = create(:learning_path, courses_count: 2)
      get :show, params: { id: learning_path.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new LearningPath' do
        courses = FactoryBot.create_list(:course, 3)
        expect {
          post :create, params: { learning_path: { name: 'New Learning Path', course_ids: courses.pluck(:id) } }
        }.to change(LearningPath, :count).by(1)
      end

      it 'renders a JSON response with the new learning_path' do
        courses = FactoryBot.create_list(:course, 3)
        post :create, params: { learning_path: { name: 'New Learning Path', course_ids: courses.pluck(:id) } }
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(learning_path_url(LearningPath.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new learning_path' do
        post :create, params: { learning_path: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:learning_path) {create(:learning_path, name: 'Test Learning Path') }

      it 'updates the requested learning path' do
        patch :update, params: { id: learning_path.id, learning_path: { name: 'Updated Learning Path' } }
        learning_path.reload
        expect(learning_path.name).to eq('Updated Learning Path')
      end

      it 'returns http success' do
        patch :update, params: { id: learning_path.id, learning_path: { name: 'Updated Learning Path' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      let(:learning_path) { create(:learning_path, name: 'Test Learning Path') }

      it 'returns http unprocessable entity' do
        patch :update, params: { id: learning_path.id, learning_path: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:learning_path) { create(:learning_path) }

    it 'returns a success response' do
      delete :destroy, params: { id: learning_path.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #add_course' do
    let(:learning_path) { create(:learning_path) }
    let(:course) { create(:course, name: 'Example Course Name', position: 11) }

    it 'adds the course to the learning path' do
      expect {
        post :add_course, params: { id: learning_path.id, course_id: course.id }
      }.to change(learning_path.courses.reload, :count).by(1)
    end

    it 'returns a success response' do
      post :add_course, params: { id: learning_path.id, course_id: course.id }
      expect(response).to be_successful
    end
  end
end
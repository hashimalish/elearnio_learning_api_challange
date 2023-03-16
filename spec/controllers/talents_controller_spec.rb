require 'rails_helper'

RSpec.describe TalentsController, type: :controller do
  describe 'GET #index' do
    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns all author' do
      talent1 = create(:talent)
      talent2 = create(:talent)

      get :index

      expect(assigns(:talents)).to match_array([talent1, talent2])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      talent = create(:talent)
      get :show, params: { id: talent.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Talent' do
        expect {
          post :create, params: { talent: { name: 'New Talent' } }
        }.to change(Talent, :count).by(1)
      end

      it 'renders a JSON response with the new Talent' do
        post :create, params: { talent: { name: 'New Talent' } }
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(talent_url(Talent.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new Talent' do
        post :create, params: { talent: { name: nil  } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("can't be blank")
      end
    end
  end


  describe 'PATCH #update' do
    context 'with valid params' do
      let(:talent) {create(:talent, name: 'Test Talent') }

      it 'updates the requested learning path' do
        patch :update, params: { id: talent.id, talent: { name: 'Updated Talent Name' } }
        talent.reload
        expect(talent.name).to eq('Updated Talent Name')
      end

      it 'returns http success' do
        patch :update, params: { id: talent.id, talent: { name: 'Updated Talent Name' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      let(:talent) { create(:talent, name: 'Test Talent') }

      it 'returns http unprocessable entity' do
        patch :update, params: { id: talent.id, talent: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:talent) { create(:talent) }

    it 'returns a success response' do
      delete :destroy, params: { id: talent.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #assign_learning_path' do
    let!(:talent) { create(:talent) }
    let!(:learning_path) { create(:learning_path) }

    it 'adds the learning path to the talent' do
      post :assign_learning_path, params: { id: talent.id, learning_path_id: learning_path.id }

      talent.reload
      expect(talent.learning_paths).to include(learning_path)
    end

    it 'returns a JSON response with the updated talent' do
      post :assign_learning_path, params: { id: talent.id, learning_path_id: learning_path.id }

      talent.reload
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(JSON.parse(talent.to_json))
    end
  end

  describe 'POST #mark_course_completed' do
    let(:talent) { create(:talent) }
    let(:course) { create(:course, name: 'Course 1', position: 2) }
    let(:course_2) { create(:course, name: 'Course 2', position: 1) }
    let(:learning_path) { create(:learning_path, course_ids: [course.id, course_2.id]) }

    context 'when the course is already completed by the talent' do
      before do 
        talent.course_enrollments << course
        talent.course_talents.find_by(course: course)&.update!(completed: true)
      end

      it 'returns an error response' do
        post :mark_course_completed, params: { id: talent.id, course_id: course.id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Course already completed' })
      end

      it 'does not mark the course as completed for the talent' do
        course_talent = course.course_talents.find_by(talent: talent)
        expect { post :mark_course_completed, params: { id: talent.id, course_id: course.id } }
          .not_to change { course_talent.completed }
      end
    end

    context 'when the course is not yet completed by the talent' do
      before do 
        course_2.update(learning_path: learning_path)
        talent.course_enrollments << course_2
      end

      it 'returns a success response' do
        post :mark_course_completed, params: { id: talent.id, course_id: course_2.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Course marked as completed for the talent' })
      end
    end
  end
end

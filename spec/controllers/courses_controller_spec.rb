require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns all author' do
      course1 = create(:course)
      course2 = create(:course)

      get :index

      expect(assigns(:courses)).to match_array([course1, course2])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      course = create(:course)
      get :show, params: { id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:author) {create(:author, name: 'Test Author') }

      it 'creates a new Course' do
        expect {
          post :create, params: { course: { name: 'New Course', author_type: 'Author', author_id: author.id, position: 2 } }
        }.to change(Course, :count).by(1)
      end

      it 'renders a JSON response with the new Course' do
        post :create, params: { course: { name: 'New Course', author_type: 'Author', author_id: author.id, position: 3 } }
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(course_url(Course.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new Course' do
        post :create, params: { course: { name: 'New Course', author_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('must exist')
      end
    end
  end


  describe 'PATCH #update' do
    context 'with valid params' do
      let(:course) {create(:course, name: 'Test Course') }

      it 'updates the requested learning path' do
        patch :update, params: { id: course.id, course: { name: 'Updated Course' } }
        course.reload
        expect(course.name).to eq('Updated Course')
      end

      it 'returns http success' do
        patch :update, params: { id: course.id, course: { name: 'Updated Course' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      let(:course) { create(:course, name: 'Test Course') }

      it 'returns http unprocessable entity' do
        patch :update, params: { id: course.id, course: { author_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:course) { create(:course) }

    it 'returns a success response' do
      delete :destroy, params: { id: course.id }
      expect(response).to be_successful
    end
  end
end

require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe 'GET #index' do
    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns all author' do
      author1 = create(:author)
      author2 = create(:author)

      get :index

      expect(assigns(:authors)).to match_array([author1, author2])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      author = create(:author)
      get :show, params: { id: author.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Author' do
        expect {
          post :create, params: { author: { name: 'New Author' } }
        }.to change(Author, :count).by(1)
      end

      it 'renders a JSON response with the new author' do
        post :create, params: { author: { name: 'New Author' } }
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(author_url(Author.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new author' do
        post :create, params: { author: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:author) {create(:author, name: 'Test Author') }

      it 'updates the requested learning path' do
        patch :update, params: { id: author.id, author: { name: 'Updated Author' } }
        author.reload
        expect(author.name).to eq('Updated Author')
      end

      it 'returns http success' do
        patch :update, params: { id: author.id, author: { name: 'Updated Author' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      let(:author) { create(:author, name: 'Test Auhtor') }

      it 'returns http unprocessable entity' do
        patch :update, params: { id: author.id, author: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:author) { create(:author) }
    let(:replacement_author) { create(:author) }

    it 'returns a success response' do
      delete :destroy, params: { id: author.id, replacement_author_id: replacement_author.id }
      expect(response).to be_successful
    end
  end
end

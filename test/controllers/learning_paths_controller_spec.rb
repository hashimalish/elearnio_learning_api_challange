RSpec.describe LearningPathsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @learning_paths" do
      learning_path = LearningPath.create(name: "Test Learning Path")
      get :index
      expect(assigns(:learning_paths)).to eq([learning_path])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      learning_path = LearningPath.create(name: "Test Learning Path")
      get :show, params: { id: learning_path.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @learning_path" do
      learning_path = LearningPath.create(name: "Test Learning Path")
      get :show, params: { id: learning_path.id }
      expect(assigns(:learning_path)).to eq(learning_path)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new learning path" do
        expect {
          post :create, params: { learning_path: { name: "New Learning Path" } }
        }.to change(LearningPath, :count).by(1)
      end

      it "assigns a newly created learning path as @learning_path" do
        post :create, params: { learning_path: { name: "New Learning Path" } }
        expect(assigns(:learning_path)).to be_a(LearningPath)
        expect(assigns(:learning_path)).to be_persisted
      end

      it "returns http success" do
        post :create, params: { learning_path: { name: "New Learning Path" } }
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        post :create, params: { learning_path: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:learning_path) { LearningPath.create(name: "Test Learning Path") }

      it "updates the requested learning path" do
        patch :update, params: { id: learning_path.id, learning_path: { name: "Updated Learning Path" } }
        learning_path.reload
        expect(learning_path.name).to eq("Updated Learning Path")
      end

      it "assigns the requested learning path as @learning_path" do
        patch :update, params: { id: learning_path.id, learning_path: { name: "Updated Learning Path" } }
        expect(assigns(:learning_path)).to eq(learning_path)
      end

      it "returns http success" do
        patch :update, params: { id: learning_path.id, learning_path: { name: "Updated Learning Path" } }
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      let(:learning_path) { LearningPath.create(name: "Test Learning Path") }

      it "returns http unprocessable entity" do
        patch :update, params: { id: learning_path.id, learning_path: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

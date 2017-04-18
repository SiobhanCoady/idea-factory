require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:idea) { FactoryGirl.create(:idea, { user: user }) }

  describe '#new' do
    before { request.session[:user_id] = user.id }
    it 'assigns an instance variable' do
      get :new
      expect(assigns(:idea)).to be_a_new(Idea)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    before { request.session[:user_id] = user.id }
    context 'with valid attributes' do
      def valid_request
        post :create, params: {
                        idea: FactoryGirl.attributes_for(:idea)
                      }
      end
      it 'creates a new idea in the database' do
        count_before = Idea.count
        valid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to the idea show page' do
        valid_request
        expect(response).to redirect_to(idea_path(Idea.last))
      end
      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context 'with invalid attributes' do
      def invalid_request
        post :create, params: {
                        idea: FactoryGirl.attributes_for(:idea, title: nil)
                      }
      end
      it 'does not create a product in the database' do
        count_before = Idea.count
        invalid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'Not signed in' do
    describe 'GET index' do
      before { get :index }
      it { expect(response).to redirect_to(user_session_path) }
    end
    describe '#edit' do
      before { get :edit, id: user.to_param }
      it { expect(response).to redirect_to(user_session_path) }
    end
    describe '#update' do
      before { patch :update, id: user.to_param, user: valid_params }
      it { expect(response).to redirect_to(user_session_path) }
    end
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_params) { { email: 'bob@example.com' } }
  context 'user is signed in' do
    before { sign_in user }
    describe 'GET index' do
      before { get :index }
      it { expect(response).to redirect_to(root_path) }
    end
    describe '#edit' do
      before { get :edit, id: user.to_param }
      it { expect(response).to redirect_to(root_path) }
    end
    describe '#update' do
      before { patch :update, id: user.to_param, user: valid_params }
      it { expect(response).to redirect_to(root_path) }
    end
  end

  context 'user is admin' do
    let(:admin_role) { FactoryGirl.create(:role, name: 'janitor') }
    let(:admin) { FactoryGirl.create(:user, roles: [admin_role]) }
    before { sign_in admin }
    describe 'GET index' do
      before { get :index }
      it { expect(response).to have_http_status(:success) }
    end
    describe '#edit' do
      before { get :edit, id: user.to_param }
      it { expect(response).to have_http_status(:success) }
    end
    describe '#update' do
      before { patch :update, id: user.to_param, user: valid_params }
      it { expect(response).to redirect_to(users_path) }
    end
  end
end

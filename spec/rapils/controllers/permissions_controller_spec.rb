describe Rapils::Controllers::PermissionsController, type: :controller do
  it { should be_a Rapils::Controllers::BaseController }

  let!(:current_user) { create(:user) }
  let!(:subject_model) { create(:access_token) }

  before { api_call_as current_user }

  describe '#create' do
    let!(:invitee) { create(:user, email: 'colleague@example.com') }

    it 'allows creation with all permission' do
      Permission.create!(subject: subject_model, owner: current_user, actions: %w[all])

      params = {
        subject_type: subject_model.class.name,
        subject_id: subject_model.id,
        email: 'colleague@example.com',
        actions: %w[read],
      }
      post :create, params: params

      expect(response.status).to eq 201
      expect(Permission.count).to eq 2
    end

    it 'allows creation with manage permission' do
      Permission.create!(subject: subject_model, owner: current_user, actions: %w[manage])

      params = {
        subject_type: subject_model.class.name,
        subject_id: subject_model.id,
        email: 'colleague@example.com',
        actions: %w[read],
      }
      post :create, params: params

      expect(response.status).to eq 201
      expect(Permission.count).to eq 2
    end

    it 'does not allow creation with read permission' do
      Permission.create!(subject: subject_model, owner: current_user, actions: %w[read])

      params = {
        subject_type: subject_model.class.name,
        subject_id: subject_model.id,
        email: 'colleague@example.com',
        actions: %w[read],
      }
      post :create, params: params

      expect(response.status).to eq 404
      expect(Permission.count).to eq 1
    end

    it 'does not allow creation with no permission' do
      params = {
        subject_type: subject_model.class.name,
        subject_id: subject_model.id,
        email: 'colleague@example.com',
        actions: %w[read],
      }
      post :create, params: params

      expect(response.status).to eq 404
      expect(Permission.count).to eq 0
    end
  end

  describe '#destroy' do
    context 'own permissions' do
      it 'allows deletion with manage permission set' do
        permission = Permission.create!(subject: subject_model, owner: current_user, actions: %w[manage])
        delete :destroy, params: { id: permission.id }

        expect(response.status).to eq 204
        expect(Permission.count).to eq 0
      end

      it 'allows deletion with all permissions set' do
        permission = Permission.create!(subject: subject_model, owner: current_user, actions: %w[all])
        delete :destroy, params: { id: permission.id }

        expect(response.status).to eq 204
        expect(Permission.count).to eq 0
      end

      it 'allows deletion of own permissions with manage' do
        permission = Permission.create!(subject: subject_model, owner: current_user, actions: %w[read])
        delete :destroy, params: { id: permission.id }

        expect(response.status).to eq 204
        expect(Permission.count).to eq 0
      end
    end

    context 'other user permissions' do
      it 'allows deletion when current_user has all permissions' do
        Permission.create!(subject: subject_model, owner: current_user, actions: %w[manage])
        permission = Permission.create!(subject: subject_model, owner: create(:user), actions: %w[read])
        delete :destroy, params: { id: permission.id }

        expect(response.status).to eq 204
        expect(Permission.count).to eq 1
      end

      it 'allows deletion when current_user has manage permission' do
        Permission.create!(subject: subject_model, owner: current_user, actions: %w[manage])
        permission = Permission.create!(subject: subject_model, owner: create(:user), actions: %w[read])
        delete :destroy, params: { id: permission.id }

        expect(response.status).to eq 204
        expect(Permission.count).to eq 1
      end

      it 'does not allow deletion unless all or delete permissions are set' do
        Permission.create!(subject: subject_model, owner: current_user, actions: %w[read write])
        permission = Permission.create!(subject: subject_model, owner: create(:user), actions: %w[read])
        delete :destroy, params: { id: permission.id }

        expect(response.status).to eq 404
        expect(Permission.count).to eq 2
      end
    end
  end
end

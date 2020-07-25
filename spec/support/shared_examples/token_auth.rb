shared_examples_for 'TokenAuth' do
  describe '#access_token' do
    subject { controller.access_token }

    it 'returns nil without headers' do
      expect(subject).to eq nil
    end

    it 'returns a token using session' do
      token = create(:access_token, token: 'xxx')
      session[:access_token] = 'xxx'
      expect(subject).to eq token
    end

    it 'returns a token using authorization header' do
      token = create(:access_token, token: 'xxx')
      controller.request.headers['Authorization'] = 'Bearer xxx'
      expect(subject).to eq token
    end

    it 'returns nil when token has expired' do
      create(:access_token, token: 'xxx', expires_at: 1.minute.ago)
      controller.request.headers['Authorization'] = 'Bearer xxx'
      expect(subject).to eq nil
    end

    it 'returns nil when token has been invalidated' do
      create(:access_token, token: 'xxx', invalidated_at: 1.minute.ago)
      controller.request.headers['Authorization'] = 'Bearer xxx'
      expect(subject).to eq nil
    end
  end

  describe '#current_user' do
    let!(:user) { create(:user) }
    let!(:access_token) { create(:access_token, token: 'xxx', user: user) }
    subject { controller.current_user }

    it 'returns nil without headers' do
      expect(subject).to eq nil
    end

    it 'returns nil when session is invalid' do
      session[:access_token] = 'xxx-404'
      expect(subject).to eq nil
    end

    it 'returns a token using session' do
      session[:access_token] = 'xxx'
      expect(subject).to eq user
    end

    it 'returns a token using authorization header' do
      controller.request.headers['Authorization'] = 'Bearer xxx'
      expect(subject).to eq user
    end
  end
end

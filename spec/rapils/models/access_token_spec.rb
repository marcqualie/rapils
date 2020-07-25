describe Rapils::Models::AccessToken do
  it { expect(described_class).to be < Rapils::Models::BaseRecord }
  it { expect(described_class.abstract_class).to eq true }

  describe '#expired?' do
    it 'returns true when expired' do
      access_token = create(:access_token, expires_at: 1.minute.ago)
      expect(access_token.expired?).to eq true
    end

    it 'returns false when expires in future' do
      access_token = create(:access_token, expires_at: 1.minute.from_now)
      expect(access_token.expired?).to eq false
    end

    it 'returns false when no expiry' do
      access_token = create(:access_token, expires_at: nil)
      expect(access_token.expired?).to eq false
    end
  end

  describe '#invalidated?' do
    it 'returns true when expired' do
      access_token = create(:access_token, invalidated_at: 1.minute.ago)
      expect(access_token.invalidated?).to eq true
    end

    it 'returns false when no expiry' do
      access_token = create(:access_token, invalidated_at: nil)
      expect(access_token.invalidated?).to eq false
    end
  end
end

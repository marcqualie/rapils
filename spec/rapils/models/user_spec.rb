describe Rapils::Models::User do
  it { expect(described_class).to be < Rapils::Models::BaseRecord }
  it { expect(described_class.abstract_class).to eq true }

  describe '#admin?' do
    it 'returns false when nil' do
      user = create(:user, admin_roles: nil)
      expect(user.admin?).to eq false
    end

    it 'returns false when empty array' do
      user = create(:user, admin_roles: [])
      expect(user.admin?).to eq false
    end

    it 'returns false when a splat array' do
      user = create(:user, admin_roles: ['*'])
      expect(user.admin?).to eq true
    end
  end

  describe '#access_granted?' do
    it 'returns false when nil' do
      user = create(:user, access_granted_at: nil)
      expect(user.access_granted?).to eq false
    end

    it 'returns false when date is in the future' do
      user = create(:user, access_granted_at: 1.day.from_now)
      expect(user.access_granted?).to eq false
    end

    it 'returns true when date is in the past' do
      user = create(:user, access_granted_at: 1.day.ago)
      expect(user.access_granted?).to eq true
    end
  end

  describe '#grant_access!' do
    it 'sets access granted timestamps' do
      user = create(:user, access_granted_at: nil)
      user.grant_access!

      expect(user.access_granted_at).to_not eq nil
    end
  end
end

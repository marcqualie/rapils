describe Rapils::Models::AccessToken do
  it { expect(described_class).to be < Rapils::Models::BaseRecord }
  it { expect(described_class.abstract_class).to eq true }
end

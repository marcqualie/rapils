describe Rapils do
  it 'has a version number' do
    expect(Rapils::VERSION).to match(/\A[0-9]+\.[0-9]+\.[0-9]+(-(alpha|beta)[0-9]+)?\z/)
  end
end

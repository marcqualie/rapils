describe Rapils::BaseController, type: :controller do
  it { should be_a ActionController::API }

  it_behaves_like 'TokenAuth'
end

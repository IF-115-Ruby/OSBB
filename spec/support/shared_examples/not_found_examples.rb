RSpec.shared_examples 'return not found exception' do |klass|
  it "showing a non-existent #{klass.name} should result in a RecordNotFound Error" do
    expect { get :show, params: { id: 9999 } }.to raise_error ActiveRecord::RecordNotFound
  end
end

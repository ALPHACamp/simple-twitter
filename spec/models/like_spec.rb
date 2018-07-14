RSpec.describe Like, type: :model do
  describe 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:tweet) }
  end
end

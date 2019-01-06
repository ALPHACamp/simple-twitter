RSpec.describe User, type: :model do
  describe 'Association' do
    it { should have_many(:replies) }
    it { should have_many(:tweets) }
    it { should have_many(:likes) }
    it { should have_many(:followships) }
  end

  describe 'Validation' do
    subject { FactoryBot.create(:user) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end
end

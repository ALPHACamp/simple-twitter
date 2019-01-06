RSpec.describe Tweet, type: :model do
  describe 'Association' do
    it { should have_many(:replies) }
    it { should have_many(:likes) }
    it { should belong_to(:user) }
  end

  describe 'Validation' do
    it { should validate_length_of(:description).is_at_most(140) }
  end
end

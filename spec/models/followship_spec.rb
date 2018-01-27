RSpec.describe Followship, type: :model do
  describe 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:following).class_name('User') }
  end

  describe 'Validation' do
    it { validate_uniqueness_of(:following_id).scoped_to(:user_id) }
  end
end

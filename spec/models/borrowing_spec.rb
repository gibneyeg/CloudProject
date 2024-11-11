require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  describe 'validations' do
    subject { build(:borrowing) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'validations' do
    subject { build(:borrowing) }
    
    it { is_expected.to validate_presence_of(:due_date) }
  end
end
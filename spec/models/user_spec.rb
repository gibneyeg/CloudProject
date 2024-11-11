require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:borrowings) }
    it { is_expected.to have_many(:books).through(:borrowings) }
  end
end
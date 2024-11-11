require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:borrowings) }
    it { is_expected.to have_many(:books).through(:borrowings) }
  end
end

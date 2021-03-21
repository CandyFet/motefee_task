require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factories' do
    subject { create :product }

    it { expect(subject).to be_valid }
  end
end

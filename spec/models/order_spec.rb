require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'factories' do
    subject { create :order }

    it { expect(subject).to be_valid }
  end
end

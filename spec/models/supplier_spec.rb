require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'factories' do
    subject { create :supplier }

    it { expect(subject).to be_valid }
  end
end

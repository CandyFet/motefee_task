require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'factories' do
    subject { create :shipment }

    it { expect(subject).to be_valid }
  end
end

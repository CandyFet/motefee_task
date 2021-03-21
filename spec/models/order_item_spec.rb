require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'factories' do
    subject { create :order_item }

    it { expect(subject).to be_valid }
  end
end

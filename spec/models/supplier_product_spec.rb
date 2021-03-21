require 'rails_helper'

RSpec.describe SupplierProduct, type: :model do
  describe 'factories' do
    subject { create :supplier_product }

    it { expect(subject).to be_valid }
  end

  describe 'associations' do
    context 'when 2 suppliers have same product' do
      let(:supplier_one) { create :supplier }
      let(:supplier_two) { create :supplier }
      let(:product) { create :product }

      it { expect(create(:supplier_product, supplier: supplier_one, product: product)).to be_valid }
      it { expect(create(:supplier_product, supplier: supplier_two, product: product)).to be_valid }
    end

    context 'when one supplier have multiple products' do
      let(:supplier) { create :supplier }
      let(:product_one) { create :product }
      let(:product_two) { create :product }

      it { expect(create(:supplier_product, supplier: supplier, product: product_one)).to be_valid }
      it { expect(create(:supplier_product, supplier: supplier, product: product_two)).to be_valid }
    end
  end
end

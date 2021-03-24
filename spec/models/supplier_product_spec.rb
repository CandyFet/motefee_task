require 'rails_helper'

RSpec.describe SupplierProduct, type: :model do
  context 'factories' do
    subject { create :supplier_product }

    it { expect(subject).to be_valid }
  end

  context 'associations' do
    describe 'when 2 suppliers have same product' do
      let(:supplier_one) { create :supplier }
      let(:supplier_two) { create :supplier }
      let(:product) { create :product }

      it { expect(create(:supplier_product, supplier: supplier_one, product: product)).to be_valid }
      it { expect(create(:supplier_product, supplier: supplier_two, product: product)).to be_valid }
    end

    describe 'when one supplier have multiple products' do
      let(:supplier) { create :supplier }
      let(:product_one) { create :product }
      let(:product_two) { create :product }

      it { expect(create(:supplier_product, supplier: supplier, product: product_one)).to be_valid }
      it { expect(create(:supplier_product, supplier: supplier, product: product_two)).to be_valid }
    end
  end

  context 'scopes' do
    describe '#by_supplier_id' do
      let(:supplier) { create :supplier }
      let(:supplier_products) { create_list :supplier_product, 5, supplier_id: supplier.id }
      let(:another_stock) { create_list :supplier_product, 10 }

      subject { described_class.by_supplier_id(supplier.id) }

      it { expect(subject).to match_array(supplier_products) }
    end

    describe '#by_product_id' do
      let(:product) { create :product }
      let(:supplier_products) { create_list :supplier_product, 5, product_id: product.id }
      let(:another_stock) { create_list :supplier_product, 10 }

      subject { described_class.by_product_id(product.id) }

      it { expect(subject).to match_array(supplier_products) }
    end
  end
end

class Api::V1::StocksController < Api::V1::ApplicationController
  expose :stocks, :set_stocks
  
  def index
    render json: stocks, each_serializer: StockSerializer, status: :ok
  end

  def show
    
  end

  def create
    
  end

  def update
    
  end

  private

  def set_stocks
    SupplierProduct.by_supplier_id(params[:supplier_id])
                   .by_product_id(params[:product_id])
  end
end

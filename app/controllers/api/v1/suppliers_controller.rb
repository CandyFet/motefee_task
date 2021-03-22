class Api::V1::SuppliersController < Api::V1::ApplicationController
  expose :suppliers, -> { Supplier.all }
  expose :supplier, :set_supplier
  def index
    render json: suppliers, each_serializer: SupplierSerializer, status: :ok
  end

  def show
    return render json: supplier, serializer: SupplierSerializer, status: :ok if supplier.present?

    render_error('supplier.error.not_found', :not_found)
  end

  def create
    supplier = Supplier.create(supplier_params)
    if supplier.save
      render json: supplier, serializer: SupplierSerializer, status: :created
    else
      render_error(supplier.errors, :unprocessable_entity)
    end
  end

  def update
    if supplier&.update(supplier_params)
      render json: supplier, serializer: SupplierSerializer, status: :ok
    else
      render_error('supplier.error.not_found', :not_found)
    end
  end

  def destroy
    if supplier.present?
      supplier.destroy
      render json: {}, status: :no_content
    else
      render_error('supplier.error.not_found', :not_found)
    end
  end

  private

  def supplier_params
    params.permit(:name)
  end

  def set_supplier
    Supplier.find(params[:id])
  rescue StandardError
    nil
  end
end

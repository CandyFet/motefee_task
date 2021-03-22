class Api::V1::ProductsController < Api::V1::ApplicationController
  expose :products, -> { Product.all }
  expose :product, :set_product
  def index
    render json: products, each_serializer: ProductSerializer, status: :ok
  end

  def show
    return render json: product, serializer: ProductSerializer, status: :ok if product.present?

    render_error('product.error.not_found', :not_found)
  end

  def create
    product = Product.create(product_params)
    if product.save
      render json: product, serializer: ProductSerializer, status: :created
    else
      render_error(product.errors, :unprocessable_entity)
    end
  end

  def update
    if product&.update(product_params)
      render json: product, serializer: ProductSerializer, status: :ok
    else
      render_error('product.error.not_found', :not_found)
    end
  end

  def destroy
    if product.present?
      product.destroy
      render json: {}, status: :no_content
    else
      render_error('product.error.not_found', :not_found)
    end
  end

  private

  def product_params
    params.permit(:name)
  end

  def set_product
    Product.find(params[:id])
  rescue StandardError
    nil
  end
end

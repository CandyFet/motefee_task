# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/stocks', type: :request do
  path '/api/v1/stocks' do
    before { create_list :supplier_product, 3 }
    get('get list of all stocks') do
      tags 'stocks'
      parameter name: :supplier_id, in: :query, type: :string
      parameter name: :product_id, in: :query, type: :string

      response(200, 'succesfull') do
        let(:supplier_id) { SupplierProduct.first.supplier_id }
        let(:product_id) { SupplierProduct.first.product_id }

        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   supplier_name: { type: :string },
                   product_name: { type: :string },
                   quantity: { type: :integer },
                   delivery_time: { type: :object }
                 }
               }

        examples 'application/json' => [
          {
            id: 1,
            supplier_name: 'supplier name',
            product_name: 'product1 name',
            quantity: 5,
            delivery_time: {
              uk: 5,
              us: 3,
              eu: 4
            }

          },
          {
            id: 2,
            supplier_name: 'supplier name',
            product_name: 'product2 name',
            quantity: 5,
            delivery_time: {
              uk: 5,
              us: 3,
              eu: 4
            }
          }
        ]

        run_test!
      end
    end

    post('create stock') do
      tags 'stocks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :stock, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(201, 'created') do
        let(:stock) { { name: 'stock name' } }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: 1,
          name: 'stock1 name'
        }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(stock[:name])
        end
      end

      response(422, 'invalid request') do
        let(:stock) { {} }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :object }
               }

        examples 'application/json' => {
          error: true,
          mesage: {
            name: 'must be present'
          }
        }

        run_test!
      end
    end
  end

  path '/api/v1/stocks/{id}' do
    get 'Retrieves a stock' do
      tags 'stocks'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'stock found') do
        let(:id) { create(:stock).id }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: '1',
          name: 'stock name'
        }

        run_test!
      end

      response(404, 'stock not found') do
        let(:id) { 'invalid' }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :string }
               }

        examples 'application/json' => {
          error: true,
          mesage: 'user not found'
        }

        run_test!
      end
    end

    patch 'Updates stock' do
      tags 'stocks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :stock, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(200, 'stock update') do
        let(:id) { create(:stock).id }
        let(:stock) { { name: 'changed name' } }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: '1',
          name: 'changed name'
        }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(stock[:name])
        end
      end

      response(404, 'stock not found') do
        let(:id) { 'invalid' }
        let(:stock) { { name: 'changed name' } }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :string }
               }

        examples 'application/json' => {
          error: true,
          mesage: 'stock not found'
        }

        run_test!
      end
    end
  end
end

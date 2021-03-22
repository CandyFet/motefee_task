# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do
  path '/api/v1/products' do
    before { create_list :product, 3 }
    get('get list of all products') do
      tags 'products'

      response(200, 'succesfull') do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string }
                 }
               }

        examples 'application/json' => [
          {
            id: 1,
            name: 'product1 name'
          },
          {
            id: 2,
            name: 'product2 name'
          }
        ]

        run_test!
      end
    end

    post('create product') do
      tags 'products'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(201, 'created') do
        let(:product) { { name: 'product name' } }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: 1,
          name: 'product1 name'
        }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(product[:name])
        end
      end

      response(422, 'invalid request') do
        let(:product) { {} }

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

  path '/api/v1/products/{id}' do
    get 'Retrieves a product' do
      tags 'products'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'product found') do
        let(:id) { create(:product).id }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: '1',
          name: 'product name'
        }

        run_test!
      end

      response(404, 'product not found') do
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

    patch 'Updates product' do
      tags 'products'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(200, 'product update') do
        let(:id) { create(:product).id }
        let(:product) { { name: 'changed name' } }
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
          expect(data['name']).to eq(product[:name])
        end
      end

      response(404, 'product not found') do
        let(:id) { 'invalid' }
        let(:product) { { name: 'changed name' } }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :string }
               }

        examples 'application/json' => {
          error: true,
          mesage: 'product not found'
        }

        run_test!
      end
    end

    delete 'Destroy product' do
      tags 'products'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string

      response(204, 'product deleted') do
        let(:id) { create(:product).id }

        run_test! do |response|
          expect(response.body).to eq('')
        end
      end

      response(404, 'product not found') do
        let(:id) { 'invalid' }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :string }
               }

        examples 'application/json' => {
          error: true,
          mesage: 'product not found'
        }

        run_test!
      end
    end
  end
end

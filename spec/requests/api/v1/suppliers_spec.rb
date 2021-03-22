# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/suppliers', type: :request do
  path '/api/v1/suppliers' do
    before { create_list :supplier, 3 }
    get('get list of all suppliers') do
      tags 'Suppliers'

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
            name: 'supplier1 name'
          },
          {
            id: 2,
            name: 'supplier2 name'
          }
        ]

        run_test!
      end
    end

    post('create supplier') do
      tags 'Suppliers'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :supplier, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(201, 'created') do
        let(:supplier) { { name: 'supplier name' } }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: 1,
          name: 'supplier1 name'
        }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(supplier[:name])
        end
      end

      response(422, 'invalid request') do
        let(:supplier) { {} }

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

  path '/api/v1/suppliers/{id}' do
    get 'Retrieves a supplier' do
      tags 'Suppliers'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'supplier found') do
        let(:id) { create(:supplier).id }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }

        examples 'application/json' => {
          id: '1',
          name: 'supplier name'
        }

        run_test!
      end

      response(404, 'supplier not found') do
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

    patch 'Updates supplier' do
      tags 'Suppliers'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :supplier, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(200, 'supplier update') do
        let(:id) { create(:supplier).id }
        let(:supplier) { { name: 'changed name' } }
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
          expect(data['name']).to eq(supplier[:name])
        end
      end

      response(404, 'supplier not found') do
        let(:id) { 'invalid' }
        let(:supplier) { { name: 'changed name' } }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :string }
               }

        examples 'application/json' => {
          error: true,
          mesage: 'supplier not found'
        }

        run_test!
      end
    end

    delete 'Destroy supplier' do
      tags 'Suppliers'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string

      response(204, 'supplier deleted') do
        let(:id) { create(:supplier).id }

        run_test! do |response|
          expect(response.body).to eq('')
        end
      end

      response(404, 'supplier not found') do
        let(:id) { 'invalid' }

        schema type: :object,
               properties: {
                 error: { type: :boolean },
                 message: { type: :string }
               }

        examples 'application/json' => {
          error: true,
          mesage: 'supplier not found'
        }

        run_test!
      end
    end
  end
end

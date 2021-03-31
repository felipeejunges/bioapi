require 'swagger_helper'

RSpec.describe API::V1::BasicHealthUnit, type: :request do
  path '/api/v1/basic_health_units' do
    get('list basic_health_units') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(
                response.body, symbolize_names: true
              ),
            },
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/basic_health_units/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show basic_health_unit') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(
                response.body, symbolize_names: true
              ),
            },
          }
        end
        run_test!
      end
    end

    delete('delete basic_health_unit') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(
                response.body, symbolize_names: true
              ),
            },
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/find_ubs' do
    parameter name: 'query', in: :query, type: :string, description: 'query', required: true
    parameter name: 'range', in: :query, type: :string, description: 'range', required: false
    parameter name: 'page', in: :query, type: :string, description: 'page', required: false
    parameter name: 'per_page', in: :query, type: :string, description: 'per_page', required: false
    get('find_ubs basic_health_unit') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(
                response.body, symbolize_names: true
              ),
            },
          }
        end
        run_test!
      end
    end
  end
end

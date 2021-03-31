require "rails_helper"

RSpec.describe API::V1::BasicHealthUnitsController, type: :controller do
  describe 'GET index' do
    it 'expect to all register return inside index request' do
      total = BasicHealthUnit.count
      get :index
      expect(assigns(:basic_health_units).length).to eq(total)
    end
  end

  describe 'GET show/:id' do
    it 'expected to show to be OK for random ID' do
      rand_id = BasicHealthUnit.order('RANDOM()').first.id
      get :show, params: { format: :json, id: rand_id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET find_ubs' do
    it 'returns 200 with only query' do
      get :find_ubs, params: { query: '-22.728090,-43.367440' }
      expect(response).to have_http_status(:ok)
    end

    it 'returns 200 with pagination' do
      get :find_ubs, params: {
        query:    '-22.728090,-43.367440',
        page:     1,
        per_page: 15,
      }
      expect(response).to have_http_status(:ok)
    end

    it 'get second page' do
      query    = '-22.728090,-43.367440'
      page     = 2
      per_page = 1

      operation = FindBasicHealthUnit.new(
        per_page: per_page,
        page:     page,
        query:    query
      )

      operation.perform

      get :find_ubs, params: {
        query:    query,
        page:     page,
        per_page: per_page,
      }

      expect(response.body).to eq(operation.result.to_json)
    end

    it 'returns errors without query' do
      get :find_ubs
      expect(response.status).to_not have_http_status(:ok)
    end

    it 'returns total_entries when change range' do
      get :find_ubs, params: { query: '-22.728090,-43.367440', range: 2 }
      expect(response).to have_http_status(:ok)
    end
  end
end

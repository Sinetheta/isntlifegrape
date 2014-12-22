require 'rails_helper'

RSpec.describe Api::TastingsController, :type => :controller do
  describe 'GET index' do
    let!(:tastings) { FactoryGirl.create_list(:tasting, 5) }

    it 'returns a successful 200 response' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end

    it 'returns all the tastings' do
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['tastings'].count).to be(tastings.count)
    end
  end

  describe 'GET show' do
    let(:tasting) { FactoryGirl.create(:tasting) }

    it 'returns a successful 200 response' do
      get :show, id: tasting, format: :json
      expect(response.status).to eq(200)
    end

    it 'returns data of an single tasting' do
      get :show, id: tasting, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['tasting']).to be_truthy
    end

    it 'returns an error if the tasting does not exist' do
      get :show, id: 10 , format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq('Tasting does not exist')
      expect(response.status).to eq(404)
    end
  end
end

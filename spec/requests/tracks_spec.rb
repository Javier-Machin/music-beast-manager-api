require 'rails_helper'

RSpec.describe 'Tracks API', type: :request do
  # add tracks owner
  let(:user) { create(:user) }

  let!(:tracks) { create_list(:track, 10, created_by: user.id) }
  let(:track_id) { tracks.first.id }

  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /tracks
  describe 'GET /tracks' do
    # make HTTP get request before each example
    before { get '/tracks', params: {}, headers: headers }

    it 'returns tracks' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json["tracks"]).not_to be_empty
      expect(json["tracks"].length).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tracks/:id
  describe 'GET /tracks/:id' do
    before { get "/tracks/#{track_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the track' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(track_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:track_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for POST /tracks
  describe 'POST /tracks' do
    # valid payload
    let(:valid_attributes) { 
      { 
        title: '2 minutes to midnight', 
        created_by: user.id,
        artist: {
          name: 'Iron Maiden'
        }
      }.to_json
    }

    context 'when the request is valid' do
      before { post '/tracks', params: valid_attributes, headers: headers }
      
      it 'creates a track' do
        expect(json['title']).to eq('2 minutes to midnight')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/tracks', params: { title: 'Foobar' }.to_json, headers: headers  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Artist can't be blank/)
      end
    end
  end

  # Test suite for PATCH /tracks/:id
  describe 'PATCH /tracks/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { patch "/tracks/#{track_id}", params: valid_attributes, headers: headers }

      it 'updates the record and returns updated item' do
        expect(JSON.parse(response.body)).to include(JSON.parse(valid_attributes))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /tracks/:id
  describe 'DELETE /tracks/:id' do
    before { delete "/tracks/#{track_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
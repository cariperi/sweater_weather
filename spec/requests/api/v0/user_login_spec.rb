require 'rails_helper'

RSpec.describe 'User Login', :vcr do
  describe 'Happy Path' do
    it 'logs in the user and returns user data including API key as a response' do
      user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password' )
      user.api_keys.create(token: 'test_key')

      params = { email: user.email,
                 password: user.password }

      post('/api/v0/sessions', params:)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)

      user = data[:data]
      expect(user).to be_a(Hash)

      expect(user).to have_key(:id)
      expect(user[:id]).to be_a(String)

      expect(user).to have_key(:type)
      expect(user[:type]).to be_a(String)
      expect(user[:type]).to eq('users')

      expect(user).to have_key(:attributes)
      expect(user[:attributes]).to be_a(Hash)

      attributes = user[:attributes]
      expect(attributes).to have_key(:email)
      expect(attributes[:email]).to be_a(String)
      expect(attributes[:email]).to eq('whatever@example.com')
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a(String)
      expect(attributes[:api_key]).to eq('test_key')

      expect(attributes).to_not have_key(:password)
      expect(attributes).to_not have_key(:password_confirmation)
      expect(attributes).to_not have_key(:pasword_digest)
    end

    it 'logs in the user and returns user data including API key as a response, when email is capitalized' do
      user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password' )
      user.api_keys.create(token: 'test_key')

      params = { email: 'Whatever@example.com',
                 password: user.password }

      post('/api/v0/sessions', params:)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)

      user = data[:data]
      expect(user).to be_a(Hash)

      expect(user).to have_key(:id)
      expect(user[:id]).to be_a(String)

      expect(user).to have_key(:type)
      expect(user[:type]).to be_a(String)
      expect(user[:type]).to eq('users')

      expect(user).to have_key(:attributes)
      expect(user[:attributes]).to be_a(Hash)

      attributes = user[:attributes]
      expect(attributes).to have_key(:email)
      expect(attributes[:email]).to be_a(String)
      expect(attributes[:email]).to eq('whatever@example.com')
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a(String)
      expect(attributes[:api_key]).to eq('test_key')

      expect(attributes).to_not have_key(:password)
      expect(attributes).to_not have_key(:password_confirmation)
      expect(attributes).to_not have_key(:pasword_digest)
    end
  end
end

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

  describe 'Sad Paths' do
    it 'returns an error message and status when the incorrect password is provided' do
      user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password' )
      user.api_keys.create(token: 'test_key')

      params = { email: 'whatever@example.com',
                 password: 'password1' }

      post('/api/v0/sessions', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq('The credentials provided are not valid.')
    end

    it 'returns an error message and status when an unregistered email is provided' do
      params = { email: 'whatever@example.com',
                 password: 'password' }

      post('/api/v0/sessions', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq('The credentials provided are not valid.')
    end

    it 'returns an error message and status if email field is missing' do
      user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password' )
      user.api_keys.create(token: 'test_key')

      params = { password: 'password' }

      post('/api/v0/sessions', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq('All fields must be provided.')
    end

    it 'returns an error message and status if password field is missing' do
      user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password' )
      user.api_keys.create(token: 'test_key')

      params = { email: 'whatever@example.com' }

      post('/api/v0/sessions', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq('All fields must be provided.')
    end
  end
end

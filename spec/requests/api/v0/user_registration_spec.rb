require 'rails_helper'

RSpec.describe 'User Registration', :vcr do
  describe 'Happy Path' do
    it 'creates a user, generates an api key, and returns user data as a response' do
      params = { email: 'Whatever@example.com',
                 password: 'password',
                 password_confirmation: 'password' }

      user_count = User.count

      post('/api/v0/users', params:)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(User.count).to eq(user_count + 1)

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
      expect(attributes[:email]).to eq(params[:email].downcase)
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a(String)
      expect(attributes).to_not have_key(:password)
      expect(attributes).to_not have_key(:password_confirmation)
      expect(attributes).to_not have_key(:pasword_digest)
    end
  end

  describe 'Sad Paths' do
    it 'returns an error message and status when passwords do not match' do
      params = { email: 'Whatever@example.com',
                 password: 'password',
                 password_confirmation: 'password1' }

      user_count = User.count

      post('/api/v0/users', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(403)
      expect(User.count).to eq(user_count)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it 'returns an error message and status when email is already taken' do
      User.create!(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')

      params = { email: 'Whatever@example.com',
                 password: 'password_1',
                 password_confirmation: 'password_1' }

      user_count = User.count

      post('/api/v0/users', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(403)
      expect(User.count).to eq(user_count)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq('Validation failed: Email has already been taken')
    end

    it 'returns an error message and status if email field is missing' do
      params = { password: 'password_1',
                 password_confirmation: 'password_1' }

      user_count = User.count

      post('/api/v0/users', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(User.count).to eq(user_count)

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
      params = { email: 'Whatever@example.com',
                 password_confirmation: 'password_1' }

      user_count = User.count

      post('/api/v0/users', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(User.count).to eq(user_count)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      errors = data[:errors]
      expect(errors[0]).to be_a(Hash)
      expect(errors[0]).to have_key(:detail)
      expect(errors[0][:detail]).to eq('All fields must be provided.')
    end

    it 'returns an error message and status if password confirmation field is missing' do
      params = { email: 'Whatever@example.com',
                 password: 'password_1' }

      user_count = User.count

      post('/api/v0/users', params:)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(User.count).to eq(user_count)

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

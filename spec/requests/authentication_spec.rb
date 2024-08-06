require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

  describe 'POST /login' do
    it 'authenticates the user' do
      post '/login', params: { email: user.email, password: 'password' }
      expect(response).to have_http_status(:ok)
      expect(json['token']).not_to be_nil
    end

    it 'returns an error when the credentials are incorrect' do
      post '/login', params: { email: user.email, password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def verify
    token = params[:token]
    decoded_token = decode_token(token)
    if decoded_token
      user_id = decoded_token[0]['user_id']
      render json: { user_id: }, status: :ok
    else
      Rails.logger.error("Invalid token. Token: #{token}")
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, 'your_secret_key')
  end

  def decode_token(token)
    JWT.decode(token, 'your_secret_key', true, { algorithm: 'HS256' })
  rescue JWT::DecodeError => e
    Rails.logger.error("Failed to decode token. Error: #{e.message}")
    nil
  end
end

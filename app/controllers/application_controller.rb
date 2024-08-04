class ApplicationController < ActionController::API
  def verify
    token = params[:token]
    begin
      decoded_token = JWT.decode(token, 'your_secret_key', true, { algorithm: 'HS256' })
      user_id = decoded_token[0]['user_id']
      render json: { user_id: }, status: :ok
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end

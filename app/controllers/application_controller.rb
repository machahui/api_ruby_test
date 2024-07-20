class ApplicationController < ActionController::Base
  include JsonWebToken
  before_action :authenticate_request
  protect_from_forgery with: :null_session, if: -> { request.format.json? }


  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    if decoded == "Token not found"
      render json: { error: 'Not authenticated' }, status: :unauthorized
    else
      @current_user = User.find(decoded[:user_id])
    end
  end
end

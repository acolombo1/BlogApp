class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    render json: { message: 'Logged.' }, status: :ok
  end
  def respond_to_on_destroy
    current_user ? log_out_failure : log_out_success
  end
  def log_out_success
    render json: { message: "Logged out." }, status: :ok
  end
  def log_out_failure
    render json: { message: "Log out failure."}, status: :unauthorized
  end
end

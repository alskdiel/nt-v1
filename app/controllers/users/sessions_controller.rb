class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    redirect_to root_path
  end

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      # if params[:user][:remember_me] == "1"
      #   resource.update(remember_created_at: Time.now, remember_me: true)
      #   resource.remember_me!
      # end
      return render json: { ret: true }
    end
    invalid_login_attempt

  end


  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield if block_given?
    render json: { ret: true }
    # respond_to_on_destroy
    # super
  end

  protected

  def invalid_login_attempt
    render json: { ret: false }
    # set_flash_message(:alert, :invalid)
    # render json: flash[:alert], status: 401
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

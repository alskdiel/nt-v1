class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    redirect_to root_path
  end

  # def create
  #   build_resource
  #
  #   super
  #   # if resource.save
  #   #   if resource.active_for_authentication?
  #   #     set_flash_message :notice, :signed_up if is_navigational_format?
  #   #     sign_up(resource_name, resource)
  #   #     return render :json => {:success => true}
  #   #   else
  #   #     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
  #   #     expire_session_data_after_sign_in!
  #   #     return render :json => {:success => true}
  #   #   end
  #   # else
  #   #   clean_up_passwords resource
  #   #   return render :json => {:success => false}
  #   # end
  # end
  #
  # # Signs in a user on sign up. You can overwrite this method in your own
  # # RegistrationsController.
  # def sign_up(resource_name, resource)
  #   sign_in(resource_name, resource)
  # end

  def confirm
    email = params[:email]
    ret = User.where(email: email).take.present?

    render json: { ret: !ret }
  end

  def confirm_nick
    nickname = params[:nickname]
    ret = UserInfo.where(nickname: nickname).take.present?

    render json: { ret: !ret }
  end

  # POST /resource
  def create
    params[:user][:password_confirmation] = params[:user][:password]
    # super
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      nickname = params[:nickname]
      birth = params[:birth]
      occupation = params[:occupation]
      sex = params[:sex]

      if resource.active_for_authentication?
        UserInfo.create(nickname: nickname,
                        birth: birth,
                        occupation: occupation,
                        sex: sex,
                        user_id: resource.id)
        sign_up(resource_name, resource)
        render json: { ret: true }
      else
        UserInfo.create(nickname: nickname,
                        birth: birth,
                        occupation: occupation,
                        sex: sex,
                        user_id: resource.id)
        expire_data_after_sign_in!
        render json: { ret: true }
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { ret: false }
    end

  end

  # GET /resource/edit
  def edit
    redirect_to root_path
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

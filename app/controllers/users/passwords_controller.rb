class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
#   def create
#     binding pry
#     self.resource = resource_class.find_by_email(resource_params[:email])
#     if resource.reset_password_sent_at.nil?  ||  Time.now > resource.reset_password_sent_at + 5.minutes
#       self.resource = resource_class.send_reset_password_instructions(resource_params)
#       if successfully_sent?(resource)
#         flash[:notice] = "You will receive an email with instructions about how to reset your password in a few minutes."
#         respond_to do |format|
#           format.html #responds with default html file
#           format.js
#         end
#       else
#         respond_to do |format|
#           format.html #responds with default html file
#           format.js{ render :js => "$(\".deviseErrors\").html(\"<span class='login-error'>Could not send reset instructions to that address.</span>\");" } #this will be the javascript file we respond with
#         end
#       end
#     else
#       flash[:error] = "Passwords can only be reset every 5 minutes."
#       respond_to do |format|
#         format.html #responds with default html file
#         format.js
#       end
#     end
#   end
# end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end

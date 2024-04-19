# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /users/upload_image
  def upload_image
    @user = current_user
    respond_to do |format|
      if params[:user].present?

        if params[:user][:image].present?
          if current_user.image.attached?
            current_user.image.purge
          end

          if current_user.update(image: params[:user][:image])
          # if current_user.image.attached?
            flash[:alert] = "Image uploaded successfully"
            render('edit', status: :ok)
          else
            logger.info("*****************************************************")
            logger.info("Not Attached")
            format.html { redirect_to edit_user_registration_path, status: :unprocessable_entity, alert: 'Failed to upload image.' }
            format.json { render json: current_user.errors, status: :unprocessable_entity }
          end
        else

          logger.info("*****************************************************")
          logger.info("No image")
          format.html { redirect_to edit_user_registration_path, status: :unprocessable_entity, alert: "No Image was submitted." }
          # format.html { redirect_to edit_user_registration_path, status: :unprocessable_entity, alert: 'No image selected.' }
          format.json { render json: current_user.errors, status: :unprocessable_entity }
        end
      else
        current_user.errors.add(:base, 'No params given')
        format.html { render :edit, status: :unprocessable_entity, alert: "Nothing was submitted." }
        # format.html { redirect_to edit_user_registration_path, status: :unprocessable_entity, alert: 'No image selected.' }
        format.json { render json: current_user, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/remove_avatar
  def remove_image
    current_user.image.purge
    redirect_to edit_user_registration_path, notice: 'Image removed successfully.'
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

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

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :image])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

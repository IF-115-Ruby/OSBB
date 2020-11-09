class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def create
    if params[:newOsbb]
      build_resource(user_params_with_osbb)
      resource.osbb_attributes = osbb_params
    else
      build_resource(sign_up_params)
    end
    resource.valid? ? save_resource : render_sign_up
  end

  private

  def render_sign_up
    render :new
    clean_up_passwords resource
    set_minimum_password_length
  end

  def save_resource
    resource.save
    if resource.active_for_authentication?
      active_resource
    else
      inactive_resource
    end
    SignUpEmailSenderWorker.perform_async(resource.id)
  end

  def active_resource
    set_flash_message! :notice, :signed_up
    sign_up(resource_name, resource)
    respond_with resource, location: after_sign_up_path_for(resource)
  end

  def inactive_resource
    set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    expire_data_after_sign_in!
    respond_with resource, location: after_inactive_sign_up_path_for(resource)
  end

  def osbb_params
    params[:user][:osbb_attributes].permit(:name, :phone, :email, :website)
  end

  def user_params_with_osbb
    sign_up_params.merge({ role: User::LEAD })
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name sex mobile password osbb_attributes])
  end
end

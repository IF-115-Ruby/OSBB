class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def create
    if params[:flag]
      build_resource(user_params)
      resource.osbb_attributes = osbb_params
      resource.valid? ? save_resource : render_sign_up
    else
      super
    end
  end

  protected

  def render_sign_up
    render :new
    clean_up_passwords resource
    set_minimum_password_length
  end

  def save_resource
    resource.save
    if resource.active_for_authentication?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end

  def osbb_params
    params[:user][:osbb_attributes].permit(:name, :phone, :email, :website)
  end

  def user_params
    sign_up_params.merge({ role: User::LEAD }) if params[:flag]
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name sex mobile password osbb_attributes])
  end
end

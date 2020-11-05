# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up

  # POST /resource
  def create
    if params[:flag]
      build_resource(sign_up_params)
      @osbb = Osbb.new(name: params[:user][:osbb][:name], phone: params[:user][:osbb][:phone], email: params[:user][:osbb][:email], website: params[:user][:osbb][:website])
      if @osbb.valid? && resource.valid?
        @osbb.save
        resource.update(osbb_id: @osbb.id, role: User::LEAD)
        yield resource if block_given?
        if resource.persisted?
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
      else
        render :new
        clean_up_passwords resource
        set_minimum_password_length
      end
    else
      super
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name sex mobile password])
  end
end

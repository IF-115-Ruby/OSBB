class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :choose_layout
  before_action :set_raven_context, :set_locale

  protected

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name sex mobile])
  end

  def choose_layout
    current_user ? 'account' : 'application'
  end

  add_flash_types :danger, :info, :warning, :success

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

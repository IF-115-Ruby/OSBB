class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  %w[facebook google_oauth2].each do |adapter|
    define_method(adapter) do
      callback_for(adapter)
    end
  end

  def callback_for(provider) # rubocop:disable Metrics/AbcSize
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: User::SOCIALS[provider.to_sym]) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url
    end
  end
end

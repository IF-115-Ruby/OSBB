class LoginForm
  include Capybara::DSL

  def visit_page
    visit("/users/sign_in")
    self
  end

  def mock_auth_hash_provider(email, provider)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
                                                                   provider: provider.to_s,
                                                                   uid: '123545',
                                                                   info: {
                                                                     first_name: 'Homer',
                                                                     last_name: 'Simpson',
                                                                     email: email
                                                                   }
                                                                 })

    self
  end
end

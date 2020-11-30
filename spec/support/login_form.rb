class LoginForm
  include Capybara::DSL

  def visit_page
    visit("/users/sign_in")
    self
  end

  def mock_auth_hash(email)
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
                                                                    provider: 'facebook',
                                                                    uid: '123545',
                                                                    info: {
                                                                      first_name: 'Mykhailo',
                                                                      last_name: 'Marusyk',
                                                                      email: email
                                                                    }
                                                                  })

    self
  end
end

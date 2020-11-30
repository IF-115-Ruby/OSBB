require 'rails_helper'
require_relative '../support/login_form'

describe User::OmniauthCallbacksController do
  let!(:user) { create(:user) }
  let(:login_form) { LoginForm.new }

  context 'when not previously registered' do
    it 'Facebook' do
      login_form.visit_page.mock_auth_hash('misha.marusyk@gmail.com').click_on('Continue with Facebook')
      expect(page).to have_content('Hello Mykhailo Marusyk!')
    end
  end

  context 'when previously registered through Devise' do
    it 'Facebook' do
      login_form.visit_page.mock_auth_hash(user.email).click_on('Continue with Facebook')
      expect(page).to have_content("Hello #{user.first_name} #{user.last_name}!")
    end
  end

  context 'when user was not persisted' do
    it 'Facebook' do
      login_form.visit_page.mock_auth_hash('').click_on('Continue with Facebook')
      expect(page).to have_content('Register Page')
    end
  end
end

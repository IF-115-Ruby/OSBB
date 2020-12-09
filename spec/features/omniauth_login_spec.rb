require 'rails_helper'
require_relative '../support/login_form'

describe User::OmniauthCallbacksController, type: :feature do
  let!(:user) { create(:user) }
  let(:login_form) { LoginForm.new }

  context 'with login Facebook' do
    context 'when not previously registered' do
      it 'successfully registered' do
        login_form.visit_page.mock_auth_hash_provider('misha.marusyk@gmail.com',
                                                      :facebook).click_on('Continue with Facebook')
        expect(page).to have_css('.greetings', text: 'Hello Homer Simpson!')
      end
    end

    context 'when previously registered through Devise' do
      it 'successfully logins' do
        login_form.visit_page.mock_auth_hash_provider(user.email,
                                                      :facebook).click_on('Continue with Facebook')
        expect(page).to have_css('div', text: "Hello #{user.first_name} #{user.last_name}!")
      end
    end

    context 'when user was not persisted' do
      it 'redirect to registered page' do
        login_form.visit_page.mock_auth_hash_provider('', :facebook).click_on('Continue with Facebook')
        expect(page).to have_css('h1', text: 'Register Page')
      end
    end
  end

  context 'with login Google' do
    context 'when not previously registered' do
      it 'successfully registered' do
        login_form.visit_page.mock_auth_hash_provider('frankivsk.osbb@gmail.com',
                                                      :google_oauth2).click_on('Continue with Google')
        expect(page).to have_css('.greetings', text: 'Hello Homer Simpson!')
      end
    end

    context 'when previously registered through Devise' do
      it 'successfully logins' do
        login_form.visit_page.mock_auth_hash_provider(user.email,
                                                      :google_oauth2).click_on('Continue with Google')
        expect(page).to have_css('div', text: "Hello #{user.first_name} #{user.last_name}!")
      end
    end

    context 'when user was not persisted' do
      it 'redirect to registered page' do
        login_form.visit_page.mock_auth_hash_provider('', :google_oauth2).click_on('Continue with Google')
        expect(page).to have_css('h1', text: 'Register Page')
      end
    end
  end
end

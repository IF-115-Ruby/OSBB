require 'rails_helper'

describe Account::Admin::OsbbsController do
  let!(:user) { create(:user, :admin) }
  let!(:osbb) { create(:osbb) }
  let!(:valid_params) { attributes_for :osbb }

  before { login_as user }

  it 'successful creating osbb' do
    visit new_account_admin_osbb_path
    fill_in 'Name', with: valid_params[:name]
    fill_in 'Phone', with: valid_params[:phone]
    fill_in 'Email', with: valid_params[:email]
    fill_in 'Website', with: valid_params[:website]
    click_on 'Create new osbb'

    expect(page).to have_text(
      "Osbb profile '#{valid_params[:name]}' - created with id:#{valid_params[:id]}"
    )
    expect(page).to have_content(valid_params[:name])
    expect(page).to have_content(valid_params[:phone])
    expect(page).to have_content(valid_params[:email])
    expect(page).to have_content(valid_params[:website])
    expect(page).to have_css('span', text: valid_params[:name])
    expect(page).to have_css('span', text: valid_params[:phone])
    expect(page).to have_css('span', text: valid_params[:email])
    expect(page).to have_css('span', text: valid_params[:website])
  end

  it 'unsuccessful creating osbb' do
    visit new_account_admin_osbb_path
    fill_in 'Name', with: '  '
    fill_in 'Phone', with: '012345678901'
    fill_in 'Email', with: 'example.email'
    fill_in 'Website', with: 'example.org'
    click_on 'Create new osbb'

    expect(page).to have_css('span.error', text: 'can not be blank')
    expect(page).to have_css(
      'span.error',
      text: 'is invalid, must be 10 digits long'
    )
    expect(page).to have_css('span.error', text: 'format is not valid')
  end

  it 'successful updating osbb' do
    visit account_admin_osbb_path(osbb)
    click_on 'Edit osbb profile'
    fill_in 'Name', with: 'Updeted test'
    fill_in 'Phone', with: '0123456777'
    fill_in 'Email', with: 'example@email.org'
    fill_in 'Website', with: 'www.example.org'
    click_on 'Edit osbb'

    expect(page).to have_text("Osbb profile \"Updeted test\" updated")
    expect(page).to have_content('Updeted test')
    expect(page).to have_content('0123456777')
    expect(page).to have_content('example@email.org')
    expect(page).to have_content('www.example.org')
    expect(page).to have_css('span', text: 'Updeted test')
    expect(page).to have_css('span', text: '0123456777')
    expect(page).to have_css('span', text: 'example@email.org')
    expect(page).to have_css('span', text: 'www.example.org')
  end

  it 'unsuccessful updating osbb' do
    visit account_admin_osbb_path(osbb)
    click_on 'Edit osbb profile'
    fill_in 'Name', with: '  '
    fill_in 'Phone', with: '012345678901'
    fill_in 'Email', with: 'example.email'
    fill_in 'Website', with: 'example.org'
    click_on 'Edit osbb'

    expect(page).to have_css('span.error', text: 'can not be blank')
    expect(page).to have_css(
      'span.error',
      text: 'is invalid, must be 10 digits long'
    )
    expect(page).to have_css('span.error', text: 'format is not valid')
  end

  it 'successful deleting osbb' do
    visit account_admin_osbb_path(osbb)
    click_on 'Delete osbb'
    expect(page).to have_text(
      "Osbb profile \"#{osbb.name}\" with id:#{osbb.id} has been deleted"
    )
    expect(page).not_to have_content(osbb.email)
  end
end

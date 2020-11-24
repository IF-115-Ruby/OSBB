require 'rails_helper'

describe Account::UsersController do
  let!(:simple) { create(:user, role: :simple) }

  before { login_as simple }

  it 'visits Osbb info page' do
    visit account_utility_providers_path
    click_on 'Assign to OSBB'

    expect(page).to have_text('OSBB info')
    expect(page).to have_css('.btn.btn-outline-primary.btn-sm', text: 'Create new OSBB')
    expect(page).to have_css('#choose-osbb-btn', text: 'Choose OSBB')
  end

  it "visits 'Create new OSBB'" do
    visit new_assign_osbb_account_user_path(simple)
    click_on 'Create new OSBB'

    expect(page).to have_text('Create OSBB')
    expect(page).to have_css('label', text: 'Name')
    expect(page).to have_css('label', text: 'Phone number')
    expect(page).to have_css('label', text: 'Email')
    expect(page).to have_css('label', text: 'Website')
  end

  it 'can choose current OSBB in search input' do
    visit new_assign_osbb_account_user_path(simple)
    find('#choose-osbb-btn', text: 'Choose OSBB').click
    find("input[placeholder='Write preferred OSBB name, phone, email or website']").set "Test"
    expect(page).to have_content('Cancel')
    expect(page).to have_css("input[value='Assign OSBB']")
  end
end

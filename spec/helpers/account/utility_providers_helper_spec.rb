require 'spec_helper'
require 'rails_helper'

describe Account::UtilityProvidersHelper do
  it 'returns css class for OTHER company type' do
    expect(helper.icon_for_company(nil)).to eq({ class: 'question-circle', color: '#c28a8a' })
  end

  it 'returns css class for ELEVATOR company type' do
    expect(helper.icon_for_company(Company::ELEVATOR)).to eq({ class: "tram", color: "#79a7b3" })
  end

  it 'returns css class for TV company type' do
    expect(helper.icon_for_company(Company::TV)).to eq({ class: "tv", color: "#42a647" })
  end

  it 'returns css class for INTERCOM company type' do
    expect(helper.icon_for_company(Company::INTERCOM)).to eq({ class: "blender-phone", color: "#ad0aff" })
  end

  it 'returns css class for INTERNET company type' do
    expect(helper.icon_for_company(Company::INTERNET)).to eq({ class: "wifi", color: "#3392ff" })
  end

  it 'returns css class for GARBAGE REMOVAL company type' do
    expect(helper.icon_for_company(Company::GARBAGE_REMOVAL)).to eq({ class: "dumpster", color: "#ff6f59" })
  end

  it 'returns css class for ELECTRICITY company type' do
    expect(helper.icon_for_company(Company::ELECTRICITY)).to eq({ class: "bolt", color: "#33b4ff" })
  end

  it 'returns css class for GAS company type' do
    expect(helper.icon_for_company(Company::GAS)).to eq({ class: "fire-alt", color: "#ff8b33" })
  end

  it 'returns css class for ACCOMMODATION PAYMENT company type' do
    expect(helper.icon_for_company(Company::ACCOMMODATION_PAYMENT)).to eq({ class: "city", color: "#6d828a" })
  end

  it 'returns css class for RENT PAYMENT company type' do
    expect(helper.icon_for_company(Company::RENT_PAYMENT)).to eq({ class: "building", color: "#8b9fa6" })
  end

  it 'returns css class for HEATING company type' do
    expect(helper.icon_for_company(Company::HEATING)).to eq({ class: "fire", color: "#e38e42" })
  end

  it 'returns css class for WATER SUPPLY company type' do
    expect(helper.icon_for_company(Company::WATER_SUPPLY)).to eq({ class: "tint", color: "#0a95ff" })
  end
end

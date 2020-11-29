require 'rails_helper'

RSpec.describe SearchOsbbsController, type: :controller do
  render_views

  let!(:osbb) do
    create(
      :osbb,
      name: 'Test Osbb',
      phone: '0123456789',
      email: 'test@email.com',
      website: 'example.com'
    )
  end

  describe 'GET#search' do
    before { Osbb.reindex }

    it 'returns success when searchs osbb' do
      Osbb.search(osbb.name)
      expect(response).to be_successful
    end

    it 'finds a searched osbb by name' do
      result = Osbb.search(osbb.name)
      expect(result).to match([osbb])
    end

    it 'finds a searched osbb by few letters of it name' do
      result = Osbb.search('est')
      expect(result).to match([osbb])
    end

    it 'finds a searched osbb by few letters inside of it name' do
      result = Osbb.search('osb')
      expect(result).to match([osbb])
    end

    it 'finds a searched osbb by it phone number' do
      result = Osbb.search('0123456789')
      expect(result).to match([osbb])
    end

    it 'finds a searched osbb by few letters of it email' do
      result = Osbb.search('mail.com')
      expect(result).to match([osbb])
    end

    it 'finds a searched osbb by few letters of it website' do
      result = Osbb.search('example.com')
      expect(result).to match([osbb])
    end

    it 'has http status success' do
      Osbb.search('mail.com')
      expect(response).to be_successful
    end

    it 'can not find an empty value' do
      result = Osbb.search('')
      expect(result).not_to match([osbb])
    end

    it 'can not find osbb with one letter' do
      result = Osbb.search('t')
      expect(result).not_to match([osbb])
    end

    it 'returns successful when get search with params' do
      get :search, xhr: true, params: { term: 'Test' }, format: :json

      expect(response).to be_successful
    end
  end
end

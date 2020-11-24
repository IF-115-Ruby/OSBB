module Searchable
  extend ActiveSupport::Concern

  included do
    searchkick word_middle: %i[name phone email website]

    def search_data
      {
        name: name,
        phone: phone,
        email: email,
        website: website
      }
    end
  end
end

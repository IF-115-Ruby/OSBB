class BillsImport < ApplicationsImport
  include CompanyDataLoader

  private

  def items_to_import
    @items_to_import ||= load_entities_to_import(Bill)
  end
end

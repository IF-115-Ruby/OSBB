class AddMeterReadingToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :meter_reading, :integer
  end
end

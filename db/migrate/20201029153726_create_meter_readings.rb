class CreateMeterReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :meter_readings do |t|
      t.integer :value

      t.timestamps
    end
  end
end

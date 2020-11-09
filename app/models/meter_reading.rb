class MeterReading < ApplicationRecord
  belongs_to :billing_contract, optional: true

  validates :value, presence: true, numericality: { only_integer: true }
  validate :value_bigger_than_previous_one?

  private

  def value_bigger_than_previous_one?
    if previous_meter_reading
      errors.add :value, "Must be bigger than previous one" if value < previous_meter_reading
    else
      true
    end
  end

  def previous_meter_reading
    billing_contract.meter_readings.order(created_at: :desc).first&.value if billing_contract
  end
end

# == Schema Information
#
# Table name: meter_readings
#
#  id                  :bigint           not null, primary key
#  value               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  billing_contract_id :bigint
#
# Indexes
#
#  index_meter_readings_on_billing_contract_id  (billing_contract_id)
#
# Foreign Keys
#
#  fk_rails_...  (billing_contract_id => billing_contracts.id)
#

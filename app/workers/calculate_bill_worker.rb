class CalculateBillWorker
  include Sidekiq::Worker
  AVERAGE_METER_READING = 20

  def perform(*_args)
    BillingContract.all.each do |billing_contract|
      meter_reading = get_meter_reading(billing_contract)
      bill_value = get_bill_value(meter_reading, billing_contract)
      billing_contract.bills.create(amount: bill_value, date: Time.now.utc, meter_reading: meter_reading)
    end
  end

  private

  def get_meter_reading(billing_contract)
    if billing_contract.last_bill
      billing_contract.meter_readings.created_between(billing_contract.last_bill.date, Time.now.utc)
                      .ordered_by_date.first&.value
    else
      billing_contract.meter_readings.ordered_by_date.first&.value
    end
  end

  def get_bill_value(meter_reading, billing_contract)
    delta_meter_reading = get_delta_reading(meter_reading, billing_contract) if meter_reading
    bill_value = calculate_bill(delta_meter_reading, billing_contract)
    edit_value_depending_payments(bill_value, billing_contract)
  end

  def get_delta_reading(meter_reading, billing_contract)
    last_meter_reading = billing_contract.last_bill&.meter_reading
    last_meter_reading ? meter_reading - last_meter_reading : meter_reading
  end

  def edit_value_depending_payments(value, contract)
    suma = if contract.last_bill
             contract.payments.created_between(contract.last_bill.date, Time.now.utc).sum(:amount) || 0
           else
             contract.payments.sum(:amount) || 0
           end
    suma += contract.last_bill.amount if contract.last_bill
    value + suma
  end

  def calculate_bill(reading, contract)
    return -(reading * contract.company.payment_coefficient) if reading

    -(AVERAGE_METER_READING * contract.company.payment_coefficient)
  end
end

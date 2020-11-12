class Account::MeterReadingsController < ApplicationController
  before_action :set_billing_contract, only: :create

  def index
    @meter_readings = helpers.utility_provider_query(MeterReading)
  end

  def new
    @meter_reading = MeterReading.new
  end

  def create
    @meter_reading = @billing_contract.meter_readings.build(meter_reading_params)
    if @meter_reading.save
      redirect_to account_utility_provider_path(@billing_contract)
    else
      flash.now[:warning] = 'Invalid meter reading parameter'
      render :new
    end
  end

  private

  def meter_reading_params
    params.require(:meter_reading).permit(:value)
  end

  def set_billing_contract
    @billing_contract = BillingContract.find_by(id: params[:utility_provider_id])
  end
end

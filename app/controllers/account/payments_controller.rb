class Account::PaymentsController < Account::AccountController
  before_action :set_payments

  def index; end

  def show
    @payment = @payments.find_by(id: params[:id])
    if @payment.present?
      render_pdf
    else
      redirect_to account_utility_provider_payments_path
      flash[:alert] = 'Payment not found!'
    end
  end

  private

  def set_payments
    @payments = helpers.utility_provider_query(Payment)
  end

  def render_pdf
    render pdf: "Invoice No. #{@payment.billing_contract}",
           page_size: 'A4',
           template: "account/payments/receipt_pdf.html.slim",
           layout: "receipt_pdf.html.slim",
           orientation: "Landscape",
           lowquality: true, zoom: 1,
           dpi: 75, encoding: 'utf8'
  end
end

class Account::PaymentsController < Account::AccountController
  def index; end

  def show
    @utility_provider = current_user.billing_contracts.find_by id: params[:id]
    if @utility_provider.present?
      respond_to do |format|
        format.html
        format.pdf { render_pdf }
      end
    else
      flash.now[:warning] = 'Contract not found!'
    end
  end

  private

  def render_pdf
    render pdf: "Invoice No. #{@utility_provider.contract_num}",
           page_size: 'A4',
           template: "account/payments/receipt_pdf.html.slim",
           layout: "receipt_pdf.html.slim",
           orientation: "Landscape",
           lowquality: true, zoom: 1,
           dpi: 75, encoding: 'utf8'
  end
end

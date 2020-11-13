module RansackHelper
  def utility_provider_query(model)
    ransack = model.ransack(params[:q])
    ransack.result.page(params[:page]).per(6)
           .where(billing_contract_id: params[:utility_provider_id])
           .order(created_at: :desc)
  end
end

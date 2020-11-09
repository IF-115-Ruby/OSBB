class TelegramWebhooksController < Telegram::Bot::UpdatesController # rubocop:disable Metrics/ClassLength
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::CallbackQueryContext

  def start!(*)
    if session?
      respond_message('Choose action', menu_markup)
    else
      save_context :auth
      respond_message('Hi! Give me your mobile number.', phone_markup)
    end
  end

  def auth
    user = User.find_by(mobile: update['message']['contact']['phone_number'])
    if user
      session[:user_id] = user.id
      session[:session_key] = session_key
    else
      respond_message('User not found.')
    end
    start!
  end

  def add_meter_reading!(*)
    if session[:session_key]
      save_context :add_meter
      respond_message("Choose utility provider", companies)
    else
      start!
    end
  end

  def add_meter(*company_name)
    session[:company] = Company.find_by(name: company_name.join(' ')).id
    save_context :save_meter_reading
    respond_message('Write meter reading')
  end

  def save_meter_reading(value, *)
    meter_reading = billing_contract.meter_readings.build(value: to_number(value))

    if meter_reading.save
      respond_message("Saved meter reading #{value}.", menu_markup)
    else
      respond_message("Can't add meter reading #{value}.", menu_markup)
    end
  end

  def companies!(*)
    return respond_message(user.companies_for_output) if session?

    start!
  end

  def disassociate!(*)
    session[:session_key] = nil

    respond_message('Account disassociated!', hide_keyboard: true)
  end

  def help!(*)
    respond_message('Available commands:
      /companies - List your utility providers
      /add_meter_reading
      /disassociate - Disassociate account')
  end

  def action_missing(*_args)
    respond_message("Method missing /#{action_options[:command]}.") if action_type == :command
  end

  def message(*)
    case update['message']['text']
    when 'My utilities providers'
      companies!
    when 'Add meter reading'
      add_meter_reading!
    when 'Disassociate account'
      disassociate!
    when 'Help'
      help!
    end
  end

  private

  def session_key
    [chat['id'], from['id']].join(':') if chat && from
  end

  def session?
    session[:session_key] && session[:user_id]
  end

  def user
    User.find_by(id: session[:user_id])
  end

  def billing_contract
    user.billing_contracts.find_by(company_id: session[:company])
  end

  def respond_message(message, markup = {})
    respond_with :message, text: message, reply_markup: markup
  end

  def menu_markup
    {
      keyboard: [[{ text: 'My utilities providers' }, { text: 'Add meter reading' }],
                 [{ text: 'Disassociate account' }, { text: 'Help' }]],
      resize_keyboard: true, one_time_keyboard: true
    }
  end

  def phone_markup
    {
      keyboard: [[{ text: 'Send Phone Number', request_contact: true }]], resize_keyboard: true, one_time_keyboard: true
    }
  end

  def companies
    {
      keyboard: user.companies.map { |c| [{ text: c.name }] }, resize_keyboard: true, one_time_keyboard: true
    }
  end

  def to_number(text)
    text.to_i if text.to_i.to_s == text
  end
end

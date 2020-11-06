class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::CallbackQueryContext

  def start!(*)
    if session?
      respond_with :message, text: 'Choose action', reply_markup: menu_markup
    else
      save_context :auth
      respond_with :message, text: 'Hi! Give me your mobile number.', reply_markup: phone_markup
    end
  end

  def auth
    user = User.find_by(mobile: update['message']['contact']['phone_number'])
    if user
      session[:user_id] = user.id
      session[:session_key] = session_key
    else
      respond_with(:message, text: "User not found.")
    end
    start!
  end

  def add_meter_reading!(*)
    if session[:session_key]
      save_context :add_meter
      respond_with :message, text: "Choose utility provider", reply_markup: {
        keyboard: user.companies.map { |c| [{ text: c.name }] }, resize_keyboard: true, one_time_keyboard: true
      }
    else
      start!
    end
  end

  def add_meter(*company_name)
    session[:company] = Company.find_by(name: company_name.join(' ')).id
    save_context :save_meter_reading
    respond_with :message, text: 'Write meter reading'
  end

  def save_meter_reading(value, *)
    billing_contract = user.billing_contracts.find_by(company_id: session[:company])

    meter_reading = billing_contract.meter_readings.build(value: to_number(value))

    if meter_reading.save
      respond_with :message, text: "Saved meter reading #{value}.", reply_markup: menu_markup
    else
      respond_with :message, text: "Can't add meter reading #{value}.", reply_markup: menu_markup
    end
  end

  def companies!(*)
    session? ? respond_with(:message, text: user.companies.map(&:name).join(', ')) : start!
  end

  def disassociate!(*)
    session[:session_key] = nil

    respond_with :message, text: 'Account disassociated!', reply_markup: { hide_keyboard: true }
  end

  def help!(*)
    respond_with :message, text: 'Available commands:
      /companies - List your utility providers
      /add_meter_reading
      /disassociate - Disassociate account'
  end

  def action_missing(*_args)
    respond_with :message, text: "Method missing /#{action_options[:command]}." if action_type == :command
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

  def to_number(text)
    text.to_i if text.to_i.to_s == text
  end
end

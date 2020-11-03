require 'rails_helper'

# rubocop:disable RSpec/ImplicitBlockExpectation
RSpec.describe TelegramWebhooksController, telegram_bot: :rails do
  let!(:user) { create :user }
  let!(:contact) { { contact: { phone_number: user.mobile } } }
  let!(:utility_provider) { create(:billing_contract, user: user) }

  describe '#start!' do
    subject { -> { dispatch_command :start } }

    context 'when logged' do
      before do
        dispatch_command :start
        dispatch_message '', contact
      end

      it { is_expected.to respond_with_message('Choose action') }

      it 'present all keys' do
        expect(bot.requests[:sendMessage].last[:reply_markup]).to eq keyboard: [
          [{ text: "My utilities providers" }, { text: "Add meter reading" }],
          [{ text: "Disassociate account" }, { text: "Help" }]
        ],
                                                                     one_time_keyboard: true,
                                                                     resize_keyboard: true
      end
    end

    context 'when not logged' do
      before do
        dispatch_command :start
      end

      it { is_expected.to respond_with_message 'Hi! Give me your mobile number.' }

      it 'present phone number key' do
        expect(bot.requests[:sendMessage].last[:reply_markup]).to eq keyboard: [
          [{ text: 'Send Phone Number', request_contact: true }]
        ],
                                                                     one_time_keyboard: true,
                                                                     resize_keyboard: true
      end
    end
  end

  describe '#auth' do
    context 'when user has account on website' do
      subject { -> { dispatch_message '', contact } }

      before { dispatch_command :start }

      it { is_expected.to respond_with_message('Choose action') }
    end

    context 'when user hasn\'t account on website' do
      subject { -> { dispatch_message '', { contact: { phone_number: '1112223334' } } } }

      before { dispatch_command :start }

      it { is_expected.to respond_with_message('Not found user.') }
    end
  end

  describe '#help!' do
    subject { -> { dispatch_command :help } }

    it { is_expected.to respond_with_message(/Available commands:/) }
  end

  describe '#companies!' do
    subject { -> { dispatch_command :companies } }

    context 'when logged' do
      before do
        dispatch_command :start
        dispatch_message '', contact
      end

      it { is_expected.to respond_with_message(user.companies.map(&:name).join(', ')) }
    end

    context 'when not logged' do
      it { is_expected.to respond_with_message('Hi! Give me your mobile number.') }
    end
  end

  describe '#add_meter_reading!' do
    subject { -> { dispatch_command :add_meter_reading } }

    context 'when logged' do
      before do
        dispatch_command :start
        dispatch_message '', contact
      end

      it { is_expected.to respond_with_message('Choose Utility provider') }
      it { expect(bot.requests[:sendMessage].last[:reply_markup]).to be_present }
    end

    context 'when not logged' do
      it { is_expected.to respond_with_message('Hi! Give me your mobile number.') }
    end
  end

  describe '#add_meter' do
    subject { -> { dispatch_message utility_provider.company.name } }

    before do
      dispatch_command :start
      dispatch_message '', contact
      dispatch_command :add_meter_reading
    end

    it { is_expected.to respond_with_message("Write Meter Reading") }
  end

  describe '#save_meter_reading' do
    before do
      dispatch_command :start
      dispatch_message '', contact
      dispatch_command :add_meter_reading
      dispatch_message utility_provider.company.name
    end

    context 'when correct meter reading' do
      subject { -> { dispatch_message meter_reading } }

      let(:meter_reading) { '13649' }

      it { is_expected.to respond_with_message("Saved Meter Reading #{meter_reading}.") }
    end

    context 'when incorrect meter reading' do
      subject { -> { dispatch_message meter_reading_wrong } }

      let(:meter_reading_wrong) { 'vasia' }

      it { is_expected.to respond_with_message("Can't add meter reading #{meter_reading_wrong}.") }
    end
  end

  describe '#disassociate!' do
    subject { -> { dispatch_command :disassociate } }

    it { is_expected.to respond_with_message("Account disassociated!") }
  end

  describe '#action_missing' do
    subject { -> { dispatch_message missing_method } }

    let(:missing_method) { '/missing_method' }

    it { is_expected.to respond_with_message("Method missing #{missing_method}.") }
  end

  describe '#message' do
    let(:companies) { user.companies.map(&:name).join(', ') }

    before do
      dispatch_command :start
      dispatch_message '', contact
      dispatch_message ' '
    end

    it { expect { dispatch_message 'My utilities providers' }.to respond_with_message(companies) }
    it { expect { dispatch_message 'Add meter reading' }.to respond_with_message('Choose Utility provider') }
    it { expect { dispatch_message 'Disassociate account' }.to respond_with_message('Account disassociated!') }
    it { expect { dispatch_message 'Help' }.to respond_with_message(/Available commands:/) }
  end
end
# rubocop:enable RSpec/ImplicitBlockExpectation

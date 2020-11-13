require 'rails_helper'

RSpec.describe Account::Admin::PaymentsController, type: :controller do
  login_admin

  let!(:correct_csv_file) { { file: fixture_file_upload('files/payments_csv.csv', 'text/csv') } }
  let!(:correct_xls_file) { { file: fixture_file_upload('files/payments_xls.xls', 'text/xls') } }
  let!(:correct_xlsx_file) { { file: fixture_file_upload('files/payments_xlsx.xlsx', 'text/xlsx') } }
  let!(:incorrect_file) { { file: fixture_file_upload('files/payments_incorrect_csv.csv', 'text/csv') } }
  let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/not_csv_file', 'text') } }

  describe 'GET#new_import' do
    before { get :new_import }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :new_import }
  end

  describe 'POST#import' do
    context 'with valid params' do
      before do
        post :import, params: {
          payments_import: correct_csv_file
        }
        post :import, params: {
          payments_import: correct_xls_file
        }
        post :import, params: {
          payments_import: correct_xlsx_file
        }
      end

      it { is_expected.to respond_with :redirect }
      it { expect([:success]).to be_present }
    end
  end

  context 'with invalid params' do
    before do
      post :import, params: {
        payments_import: incorrect_file
      }
    end

    it { is_expected.to render_template :new_import }

    it 'raise error' do
      error = 'Please update your spreadsheet and try agin.'
      expect { raise error }.to raise_error(RuntimeError)
    end
  end

  context 'with unknown type of file' do
    before do
      post :import, params: {
        payments_import: incorrect_type_of_file
      }
    end

    it { is_expected.to render_template :new_import }

    it 'raise error' do
      error = "Unknown file type:"
      expect { raise error }.to raise_error(RuntimeError)
    end
  end

  context 'with empty params' do
    before do
      post :import, params: nil
    end

    it { is_expected.to render_template :new_import }
    it { expect([:danger]).to be_present }

    it 'raise error' do
      error = 'Field can not be empty!'
      expect { raise error }.to raise_error(StandardError)
    end
  end
end

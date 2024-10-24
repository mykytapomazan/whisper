require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    context 'when not signed in' do
      it 'is responds with redirect' do
        get root_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when logged in' do
      it 'is successful' do
        user = create(:user)
        sign_in user
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end

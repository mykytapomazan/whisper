require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'POST create' do
    context 'when not signed in' do
      it 'is respond with redirect' do
        post posts_path, params: { post: { body: 'New post body' } }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when logged in' do
      it 'create a new post' do
        user = create(:user)
        sign_in user
        expect do
          post posts_path, params: { post: { body: 'New post body' } }
        end.to change { Post.count }.by(1)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

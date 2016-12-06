require 'rails_helper'

RSpec.describe 'UserLogin', type: :request do
  describe 'GET /login' do
    it 'renders log in form' do
      get login_path
      expect(response).to have_http_status(200)
      expect(response).to render_template 'sessions/new'
    end
  end

  describe 'POST /login' do
    it 'does not log in an invalid user' do
      get login_path
      post login_path, params: { session: { email: '', password: '' } }
      expect(response).to render_template 'sessions/new'
      expect(flash.empty?).to be_falsey
      get root_path
      expect(flash.empty?).to be_truthy
    end

    it 'logs in a valid user and logs him out afterwards' do
      user = User.create(email: 'user@example.com', password: 'pwd', password_confirmation: 'pwd', email_confirmed: true)
      get login_path
      post login_path, params: { session: { email: user.email, password: 'pwd' } }
      expect(response).to redirect_to user_path(user)
      follow_redirect!
      expect(response).to render_template 'users/show'
      expect(response.body).not_to include "<a href=\"#{login_path}\">"
      expect(response.body).to include "<a href=\"#{logout_path}\">"
      expect(response.body).to include "<a href=\"#{user_path(user)}\">"
      delete logout_path
      expect(response).to redirect_to root_path
      follow_redirect!
      expect(response.body).to include "<a href=\"#{login_path}\">"
      expect(response.body).not_to include "<a href=\"#{logout_path}\">"
      expect(response.body).to include "<a href=\"#{new_user_path}\">"
    end
  end
end
